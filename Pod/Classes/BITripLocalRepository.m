#import "BITripLocalRepository.h"
#import "BITrip.h"
#import "BITripSerializer.h"
#import "BITripMetadata.h"

@implementation BITripLocalRepository {
    NSString* _seed;
    BITripSerializer *_serializer;
}

- (instancetype)initWithSeed:(NSString *)seed {
    self = [super init];
    if (self) {
        _seed = seed;
        _serializer = [BITripSerializer new];
    }

    return self;
}

+ (instancetype)repositoryWithSeed:(NSString *)seed {
    return [[self alloc] initWithSeed:seed];
}

- (BITripMetadata *)storeTrip:(BITrip *)tripToStore error:(NSError **)error {
    NSString *serializedTrip = [_serializer serialize:tripToStore];
    BITripMetadata *tripMetadata = [[BITripMetadata alloc] initWithName:[tripToStore getName]];
    NSString *fileKey = [self generateKeyForMetadata:tripMetadata];
    [[NSUserDefaults standardUserDefaults] setObject:serializedTrip forKey:fileKey];
    [self storeMetadata: tripMetadata];
    return tripMetadata;
}

- (void)storeMetadata:(BITripMetadata *)metadata {

}

- (NSString *)generateKeyForMetadata:(BITripMetadata *)metadata {
    return [NSString stringWithFormat:@"%@_%@", _seed, [metadata getKey]];
}

-(BITrip *) loadTripWithMetadata:(BITripMetadata *) tripMetadata{
    NSString *fileKey = [self generateKeyForMetadata:tripMetadata];
    NSString*synchronizedTrip = [[NSUserDefaults standardUserDefaults] objectForKey: fileKey];
    BITrip *deSerializedTrip = [_serializer deserialize:synchronizedTrip];
    return deSerializedTrip;
}

- (NSArray *)loadAllTripsMetadata {
    return @[];
}

@end