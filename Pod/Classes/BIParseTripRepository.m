#import <CFNetwork/CFNetwork.h>
#import "BIParseTripRepository.h"
#import "BITripMetadata.h"
#import "BITrip.h"
#import "PFAnalytics.h"
#import "Parse.h"
#import "BITripMetadataSerializer.h"
#import "BITripSerializer.h"


@implementation BIParseTripRepository {
    BITripSerializer *_serializer;
    BITripMetadataSerializer *_metadataSerializer;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _serializer = [BITripSerializer new];
        _metadataSerializer = [[BITripMetadataSerializer alloc] init];
    }
    return self;
}


- (void)storeTrip:(BITrip *)tripToStore responseBlock:(void (^)(BITripMetadata *, NSError *))responseBlock {
    NSString *serializedTrip = [_serializer serialize:tripToStore];
    BITripMetadata *tripMetadata = [[BITripMetadata alloc] initWithName:[tripToStore getName]];

    PFObject *tripObject = [PFObject objectWithClassName:@"Trip"];
    tripObject[@"serialized"] = serializedTrip;
    tripObject[@"metadataKey"] = [tripMetadata getKey];
    __block BIParseTripRepository *bSelf = self;
    [tripObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded && error == nil){
            NSString *serializedMetadata = [bSelf->_metadataSerializer serialize:tripMetadata];
            PFObject *tripMetadataPF = [PFObject objectWithClassName:@"TripMetadata"];
            tripMetadataPF[@"serialized"] = serializedMetadata;
            tripMetadataPF[@"metadataKey"] = [tripMetadata getKey];

            [tripMetadataPF saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(succeeded && error == nil){
                    responseBlock(tripMetadata, nil);
                } else {
                    responseBlock(nil, error);
                }
            }];
        } else {
            responseBlock(nil, error);
        }
        bSelf = nil;
    }];
}

-(void) deleteTripForMetadata:(BITripMetadata *) metadata responseBlock:(void(^)(BOOL succeeded, NSError *)) callback {
    PFQuery *tripQuery = [self createQueryForTrip:metadata];
    PFQuery *metadataQuery = [self createQueryForMetadata:metadata];

    [tripQuery getFirstObjectInBackgroundWithBlock:^(PFObject *tripObject, NSError *error) {
        if (error) {
            callback(NO, error);
            return;
        }
        [metadataQuery getFirstObjectInBackgroundWithBlock:^(PFObject *metadataObject, NSError *error) {
            if (error) {
                callback(NO, error);
                return;
            }
            [tripObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(!succeeded){
                    callback(NO, error);
                } else {
                    [metadataObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        callback(succeeded, error);
                    }];
                }
            }];
        }];
    }];
}

- (void)loadTripWithMetadata:(BITripMetadata *)tripMetadata responseBlock:(void (^)(BITrip *, NSError *))block {
    PFQuery *query = [self createQueryForTrip:tripMetadata];
    __block BIParseTripRepository *bSelf = self;
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *metadata, NSError *error) {
        if(metadata != nil && error == nil){
            NSString* serializedTrip = metadata[@"serialized"];
            BITrip *deSerializedTrip = [bSelf->_serializer deserialize:serializedTrip];
            block(deSerializedTrip, nil);
        } else {
            block(nil, error);
        }
        bSelf = nil;
    }];
}

- (PFQuery *)createQueryForTrip:(BITripMetadata *)tripMetadata {
    PFQuery *query = [PFQuery queryWithClassName:@"Trip"];
    [query whereKey:@"metadataKey" equalTo:[tripMetadata getKey]];
    return query;
}

- (PFQuery *)createQueryForMetadata:(BITripMetadata *)tripMetadata {
    PFQuery *query = [PFQuery queryWithClassName:@"TripMetadata"];
    [query whereKey:@"metadataKey" equalTo:[tripMetadata getKey]];
    return query;
}

- (void)loadAllTripsMetadata:(void (^)(NSArray*, NSError *))responseBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"TripMetadata"];
    [query orderByDescending:@"createdAt"];
    __block BIParseTripRepository *bSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects, NSError *error) {
        if(pfObjects != nil && error == nil){
            NSMutableArray *metadataArray = [NSMutableArray new];
            for (PFObject *pfObject in pfObjects) {
                NSString *serializedMetadata = pfObject[@"serialized"];
                BITripMetadata *deSerializedMetadata = [bSelf->_metadataSerializer deserialize:serializedMetadata];
                if (deSerializedMetadata != nil){
                    [metadataArray addObject:deSerializedMetadata];
                }
            }
            responseBlock(metadataArray, nil);
        } else {
            responseBlock(nil, error);
        }
        bSelf = nil;
    }];
}

@end