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


- (BITripMetadata *)storeTrip:(BITrip *)tripToStore error:(NSError **)error {
    NSString *serializedTrip = [_serializer serialize:tripToStore];
    BITripMetadata *tripMetadata = [[BITripMetadata alloc] initWithName:[tripToStore getName]];

    PFObject *tripObject = [PFObject objectWithClassName:@"Trip"];
    tripObject[@"serialized"] = serializedTrip;
    tripObject[@"metadataKey"] = [tripMetadata getKey];
    [tripObject saveInBackground];

    [self storeMetadata:tripMetadata];
    return tripMetadata;
}

- (BITrip *)loadTripWithMetadata:(BITripMetadata *)tripMetadata {
    PFQuery *query = [PFQuery queryWithClassName:@"Trip"];
    [query whereKey:@"metadataKey" equalTo:[tripMetadata getKey]];
    NSError* error = nil;
    PFObject *metadata = [query getFirstObject:&error];
    if(metadata != nil){
        NSString* serializedTrip = metadata[@"serialized"];
        BITrip *deSerializedTrip = [_serializer deserialize:serializedTrip];
        return deSerializedTrip;
    }
    return nil;
}

- (NSArray *)loadAllTripsMetadata {
    PFQuery *query = [PFQuery queryWithClassName:@"TripMetadata"];
    [query orderByDescending:@"createdAt"];
    NSError *error = nil;
    NSArray *pfObjects = [query findObjects:&error];
    NSMutableArray *metadataArray = [NSMutableArray new];
    for (PFObject *pfObject in pfObjects) {
        NSString *serializedMetadata = pfObject[@"serialized"];
        BITripMetadata *deSerializedMetadata = [_metadataSerializer deserialize:serializedMetadata];
        if (deSerializedMetadata != nil){
            [metadataArray addObject:deSerializedMetadata];
        }
    }
    return metadataArray;
}

- (void)storeMetadata:(BITripMetadata *)metadata {
    NSString *serializedMetadata = [_metadataSerializer serialize:metadata];
    PFObject *tripMetadata = [PFObject objectWithClassName:@"TripMetadata"];
    tripMetadata[@"serialized"] = serializedMetadata;
    [tripMetadata saveInBackground];
}

@end