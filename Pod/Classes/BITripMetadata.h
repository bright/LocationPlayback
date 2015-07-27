#import <Foundation/Foundation.h>


@interface BITripMetadata : NSObject <NSCoding>

- (instancetype)initWithUrl:(NSURL *)url key:(NSString *)key name:(NSString *)name startDate:(NSDate *)startDate;

- (instancetype)initWithName:(NSString *)name startDate:(NSDate *)startDate;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToMetadata:(BITripMetadata *)metadata;

- (NSUInteger)hash;

- (NSString *)getKey;

- (NSDictionary *)toDictionary;

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

- (id)initWithCoder:(NSCoder *)coder;

- (void)encodeWithCoder:(NSCoder *)coder;

- (NSString *)getName;

- (NSDate *)getStartDate;

@end