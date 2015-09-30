#import "NSString+Date.h"


@implementation NSString (Date)

+ (NSDateFormatter*)stringDateFormatter
{
    static NSDateFormatter* formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss.SSSSSS ZZZ"];
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    return formatter;
}

- (NSDate*)toDateFromStringDate
{
    return [[NSString stringDateFormatter] dateFromString:self];
}

+ (NSString*)stringDateFromDate:(NSDate*)date
{
    return [[NSString stringDateFormatter] stringFromDate:date];
}

@end