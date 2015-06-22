#import <Foundation/Foundation.h>


@interface Trip : NSObject

- (instancetype)initWithStartDate:(NSDate *)startDate entries:(NSArray *)array;

- (NSArray *)getEntries;

-(NSDate *) getStartDate;

@end