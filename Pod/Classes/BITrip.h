#import <Foundation/Foundation.h>

@class BITripMetadata;

@interface BITrip : NSObject

- (instancetype)initWithStartDate:(NSDate *)startDate entries:(NSArray *)tripEntries name:(NSString *)name;

- (NSArray *)getEntries;

-(NSDate *) getStartDate;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToTrip:(BITrip *)trip;

- (NSUInteger)hash;

-(NSString *) getName;

@end