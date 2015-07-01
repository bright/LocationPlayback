#import "BITrip.h"
#import "BITripEntry.h"
#import "BITripMetadata.h"
#import "NSString+Date.h"
@implementation BITrip {
    NSArray *_entries;
    NSDate *_startDate;
    NSDate *_endDate;
    NSString *_name;
}

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate entries:(NSArray *)tripEntries name:(NSString *)name {
    self = [super init];
    if (self) {
        _startDate = startDate;
        _endDate = endDate;
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

- (NSDate *)getEndDate {
    return _endDate;
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
    if (_startDate != trip->_startDate && !((NSInteger)[_startDate timeIntervalSince1970] == (NSInteger)[trip->_startDate timeIntervalSince1970]))
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

-(NSDictionary *) toDictionary {
    NSMutableArray *entriesAsDict = [NSMutableArray new];
    for(BITripEntry *entry in _entries){
        NSDictionary *entryAsDict = [entry toDictionary];
        [entriesAsDict addObject: entryAsDict];
    }
    return @{
            @"startDate": [NSString stringDateFromDate:_startDate],
            @"name": _name,
            @"entries": entriesAsDict
    };
}


- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    NSString* name = dictionary[@"name"];
    NSDate* startDate = [dictionary[@"startDate"] toDateFromStringDate];
    NSArray*entriesJsons = dictionary[@"entries"];

    NSMutableArray*entriesList = [NSMutableArray new];
    for(NSDictionary *entryDict in entriesJsons){
        BITripEntry* tripEntry = [[BITripEntry alloc] initFromDictionary: entryDict];
        [entriesList addObject:tripEntry];
    }
    return [[BITrip alloc] initWithStartDate:startDate endDate:nil entries:entriesList name:name];
}
@end