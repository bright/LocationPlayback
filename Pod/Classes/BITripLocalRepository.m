#import "BITripLocalRepository.h"
#import "BITrip.h"
#import "BITripSerializer.h"
#import "BITripMetadata.h"
#import "BITripMetadataSerializer.h"

@implementation BITripLocalRepository {
    NSString *_seed;
    BITripSerializer *_serializer;
    BITripMetadataSerializer *_metadataSerializer;
}

- (instancetype)initWithSeed:(NSString *)seed {
    self = [super init];
    if (self) {
        _seed = seed;
        _serializer = [BITripSerializer new];
        _metadataSerializer = [[BITripMetadataSerializer alloc] init];
    }

    return self;
}

- (void)storeTrip:(BITrip *)tripToStore responseBlock:(void (^)(BITripMetadata *, NSError *))responseBlock {
    NSString *serializedTrip = [_serializer serialize:tripToStore];
    BITripMetadata *tripMetadata = [[BITripMetadata alloc] initWithName:[tripToStore getName] startDate:[tripToStore getStartDate]];
    NSString *fileKey = [self generateKeyForTripWithMetadata:tripMetadata];
    [[NSUserDefaults standardUserDefaults] setObject:serializedTrip forKey:fileKey];
    [self storeMetadata:tripMetadata];
    responseBlock(tripMetadata, nil);
}

- (NSString *)generateKeyForMetadata:(BITripMetadata *)metadata {
    return [NSString stringWithFormat:@"BITripLocalRepository_metadata_%@_%@", _seed, [metadata getKey]];
}

- (NSString *)generateKeyPrefixForMetadata {
    return [NSString stringWithFormat:@"BITripLocalRepository_metadata_%@", _seed];
}

- (void)storeMetadata:(BITripMetadata *)metadata {
    NSString *serializedMetadata = [_metadataSerializer serialize:metadata];
    NSString *metadataKey = [self generateKeyForMetadata:metadata];
    [[NSUserDefaults standardUserDefaults] setObject:serializedMetadata forKey:metadataKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)generateKeyForTripWithMetadata:(BITripMetadata *)metadata {
    return [NSString stringWithFormat:@"BITripLocalRepository_%@_%@", _seed, [metadata getKey]];
}

- (void)loadTripWithMetadata:(BITripMetadata *)tripMetadata responseBlock:(void (^)(BITrip *, NSError *))block {
    NSString *fileKey = [self generateKeyForTripWithMetadata:tripMetadata];
    NSString *synchronizedTrip = [[NSUserDefaults standardUserDefaults] objectForKey:fileKey];
    BITrip *deSerializedTrip = [_serializer deserialize:synchronizedTrip];
    block(deSerializedTrip, nil);
}

- (void)loadAllTripsMetadata:(void (^)(NSArray *, NSError *))responseBlock {
    NSMutableArray *metadataArray = [NSMutableArray new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *metadataPrefix = [self generateKeyPrefixForMetadata];
    for (NSString *key in [[userDefaults dictionaryRepresentation] allKeys]) {
        if ([key hasPrefix:metadataPrefix]) {
            NSString *serializedMetadata = [userDefaults objectForKey:key];
            BITripMetadata *deSerializedMetadata = [_metadataSerializer deserialize:serializedMetadata];
            [metadataArray addObject:deSerializedMetadata];
        }
    }
    responseBlock(metadataArray, nil);
}

@end