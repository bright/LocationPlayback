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

+ (instancetype)repositoryWithSeed:(NSString *)seed {
    return [[self alloc] initWithSeed:seed];
}

- (BITripMetadata *)storeTrip:(BITrip *)tripToStore error:(NSError **)error {
    NSString *serializedTrip = [_serializer serialize:tripToStore];
    BITripMetadata *tripMetadata = [[BITripMetadata alloc] initWithName:[tripToStore getName]];
    NSString *fileKey = [self generateKeyForTripWithMetadata:tripMetadata];
    [[NSUserDefaults standardUserDefaults] setObject:serializedTrip forKey:fileKey];
    [self storeMetadata:tripMetadata];
    return tripMetadata;
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

- (BITrip *)loadTripWithMetadata:(BITripMetadata *)tripMetadata {
    NSString *fileKey = [self generateKeyForTripWithMetadata:tripMetadata];
    NSString *synchronizedTrip = [[NSUserDefaults standardUserDefaults] objectForKey:fileKey];
    BITrip *deSerializedTrip = [_serializer deserialize:synchronizedTrip];
    return deSerializedTrip;
}

- (NSArray *)loadAllTripsMetadata {
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
    return metadataArray;
}

@end