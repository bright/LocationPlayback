#import <Foundation/Foundation.h>

@class BITripMetadata;

@interface BITrip : NSObject

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate entries:(NSArray *)tripEntries name:(NSString *)name;

- (NSArray *)getEntries;

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

- (CGFloat)averageSpeed;

-(NSDate *) getStartDate;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToTrip:(BITrip *)trip;

- (NSUInteger)hash;

-(NSString *) getName;

- (NSDictionary *)toDictionary;

- (NSDate *)getEndDate;
@end