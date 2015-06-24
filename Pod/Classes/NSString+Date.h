#import <Foundation/Foundation.h>

@interface NSString (Date)
- (NSDate*)toDateFromStringDate;
+ (NSString*)stringDateFromDate:(NSDate*)date;
@end