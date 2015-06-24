#import <Foundation/Foundation.h>


@interface BITripMetadata : NSObject <NSCoding>
- (instancetype)initWithKey:(NSString *)key name:(NSString *)name;

- (instancetype)initWithUrl:(NSURL *)url key:(NSString *)key name:(NSString *)name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)metadataWithName:(NSString *)name;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToMetadata:(BITripMetadata *)metadata;

- (NSUInteger)hash;

- (NSString *)getKey;

- (id)initWithCoder:(NSCoder *)coder;

- (void)encodeWithCoder:(NSCoder *)coder;

+ (instancetype)metadataWithUrl:(NSURL *)url key:(NSString *)key name:(NSString *)name;

+ (instancetype)metadataWithKey:(NSString *)key name:(NSString *)name;

@end