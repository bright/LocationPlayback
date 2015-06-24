#import "BITripMetadataSerializer.h"
#import "BITripMetadata.h"


@implementation BITripMetadataSerializer {}

- (NSString *)serialize:(BITripMetadata *)metadata {
    NSError *writeError = nil;
    NSDictionary *tripAsDict = [metadata toDictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tripAsDict options:nil error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(BITripMetadata *) deserialize:(NSString *) serializedMetadata {
    NSData *data = [serializedMetadata dataUsingEncoding:NSUTF8StringEncoding];
    NSError *readError = nil;
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:nil error: &readError];
    BITripMetadata *trip = [[BITripMetadata alloc] initFromDictionary: jsonObj];
    return trip;
}

@end