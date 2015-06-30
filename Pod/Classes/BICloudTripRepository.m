#import <CFNetwork/CFNetwork.h>
#import "BICloudTripRepository.h"
#import "BITripMetadata.h"
#import "BITrip.h"
#import "PFAnalytics.h"
#import "Parse.h"
#import "BITripMetadataSerializer.h"
#import "BITripSerializer.h"


@implementation BICloudTripRepository {
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
    [tripObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded && error == nil){
            NSString *serializedMetadata = [_metadataSerializer serialize:tripMetadata];
            PFObject *tripMetadataPF = [PFObject objectWithClassName:@"TripMetadata"];
            tripMetadataPF[@"serialized"] = serializedMetadata;
            [tripMetadataPF saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(succeeded && error == nil){
                    responseBlock(tripMetadata, nil);
                } else {
                    responseBlock(nil, [[NSError alloc] initWithDomain:@"BICloudTripRepository" code:1 userInfo:nil]);
                }
            }];
        } else {
            responseBlock(nil, [[NSError alloc] initWithDomain:@"BICloudTripRepository" code:1 userInfo:nil]);
        }
    }];
}

- (void)loadTripWithMetadata:(BITripMetadata *)tripMetadata responseBlock:(void (^)(BITrip *, NSError *))block {
    PFQuery *query = [PFQuery queryWithClassName:@"Trip"];
    [query whereKey:@"metadataKey" equalTo:[tripMetadata getKey]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *metadata, NSError *error) {
        if(metadata != nil && error == nil){
            NSString* serializedTrip = metadata[@"serialized"];
            BITrip *deSerializedTrip = [_serializer deserialize:serializedTrip];
            block(deSerializedTrip, nil);
        } else {
            block(nil, [[NSError alloc] initWithDomain:@"BICloudTripRepository" code:1 userInfo:nil]);
        }
    }];
}

- (void)loadAllTripsMetadata:(void (^)(NSArray*, NSError *))responseBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"TripMetadata"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects, NSError *error) {
        if(pfObjects != nil && error == nil){
            NSMutableArray *metadataArray = [NSMutableArray new];
            for (PFObject *pfObject in pfObjects) {
                NSString *serializedMetadata = pfObject[@"serialized"];
                BITripMetadata *deSerializedMetadata = [_metadataSerializer deserialize:serializedMetadata];
                if (deSerializedMetadata != nil){
                    [metadataArray addObject:deSerializedMetadata];
                }
            }
            responseBlock(metadataArray, nil);
        } else {
            responseBlock(nil, [[NSError alloc] initWithDomain:@"BICloudTripRepository" code:1 userInfo:nil]);
        }
    }];
}

@end