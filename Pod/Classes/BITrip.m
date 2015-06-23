#import "BITrip.h"
#import "BITripEntry.h"
#import "BITripMetadata.h"

@implementation BITrip {
    NSArray *_entries;
    NSDate *_startDate;
    NSString *_name;
}

- (instancetype)initWithStartDate:(NSDate *)startDate entries:(NSArray *)tripEntries name:(NSString *)name {
    self = [super init];
    if (self) {
        _startDate = startDate;
        _entries = tripEntries;
        _name = name;
    }
    return self;
}

- (NSArray *)getEntries {
    return _entries;
}

- (NSDate *)getStartDate {
    return _startDate;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToTrip:other];
}

- (BOOL)isEqualToTrip:(BITrip *)trip {
    if (self == trip)
        return YES;
    if (trip == nil)
        return NO;
    if ([_entries count] != [trip->_entries count]) {
        return NO;
    } else {
        for (NSInteger i = 0; i < [_entries count]; i++) {
            BITripEntry *entry1 = _entries[(NSUInteger) i];
            BITripEntry *entry2 = trip->_entries[(NSUInteger) i];
            BOOL areEqual = [entry1 isEqualToEntry:entry2];
            if (!areEqual) return NO;
        }
    }
    if (_startDate != trip->_startDate && ![_startDate isEqualToDate:trip->_startDate])
        return NO;
    if (_name != trip->_name && ![_name isEqualToString:trip->_name])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [_entries hash];
    hash = hash * 31u + [_startDate hash];
    hash = hash * 31u + [_name hash];
    return hash;
}

- (NSString *)getName {
    return _name;
}


@end