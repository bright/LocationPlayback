#import <Foundation/Foundation.h>

@class BITripMetadata;


@interface BITripMetadataSerializer : NSObject

- (NSString *)serialize:(BITripMetadata *)metadata;

- (BITripMetadata *)deserialize:(NSString *)serializedMetadata;

@end