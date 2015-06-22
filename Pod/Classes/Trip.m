#import "Trip.h"


@implementation Trip {
    NSArray *_entries;
    NSDate *_startDate;
}

- (instancetype)initWithStartDate:(NSDate *)startDate entries:(NSArray *)tripEntries {
    self = [super init];
    if(self){
        _startDate = startDate;
        _entries = tripEntries;
    }
    return self;
}

-(NSArray *) getEntries {
    return _entries;
}

- (NSDate *)getStartDate {
    return _startDate;
}


@end