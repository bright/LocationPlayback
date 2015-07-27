#import "BITripEntry.h"
#import "NSString+Date.h"

@interface BITripEntry ()

@property(nonatomic) CLLocationCoordinate2D coordinate2D;
@property(nonatomic) CGFloat speed;
@property(nonatomic) NSNumber* acceleration;
@property(nonatomic, strong) NSDate *timestamp;

@end

@implementation BITripEntry {}

- (instancetype)initWithLocation: (CLLocation *) location {
    return [self initWithLocation:location acceleration:nil];
}

- (instancetype)initWithLocation: (CLLocation *) location acceleration:(NSNumber *) acceleration {
    self = [super init];
    if (self) {
        self.coordinate2D = location.coordinate;
        self.speed = (CGFloat) location.speed;
        self.timestamp = [NSDate date];
        self.acceleration = acceleration;
    }
    return self;
}

- (NSDate *)getTimestamp {
    return _timestamp;
}

-(CLLocationCoordinate2D) getCoordinate {
    return _coordinate2D;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"trip entry with speed: %@", @(self.speed)];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToEntry:other];
}

- (BOOL)isEqualToEntry:(BITripEntry *)entry {
    if (self == entry)
        return YES;
    if (entry == nil)
        return NO;
    if (self.coordinate2D.latitude != entry.coordinate2D.latitude)
        return NO;
    if (self.coordinate2D.longitude != entry.coordinate2D.longitude)
        return NO;
    if (self.speed != entry.speed)
        return NO;
    if (self.acceleration != entry.acceleration && !([self.acceleration isEqualToNumber:entry.acceleration]))
        return NO;
    if (self.timestamp != entry.timestamp && !((NSInteger)[self.timestamp timeIntervalSince1970] == (NSInteger)[entry.timestamp timeIntervalSince1970]))
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [[NSNumber numberWithDouble:self.coordinate2D.latitude] hash];
    hash = hash * 31u + [[NSNumber numberWithDouble:self.coordinate2D.longitude] hash];
    hash = hash * 31u + [[NSNumber numberWithDouble:self.speed] hash];
    hash = hash * 31u + [self.acceleration hash];
    hash = hash * 31u + [self.timestamp hash];
    return hash;
}


- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: @{
            @"latitude": @(_coordinate2D.latitude),
            @"longitude": @(_coordinate2D.longitude),
            @"speed": @(_speed),
            @"timestamp": [NSString stringDateFromDate:_timestamp]
    }];
    if(_acceleration != nil){
        dict[@"acceleration"] = _acceleration;
    }
    return dict;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self){
        CLLocationDegrees latitude = [dictionary[@"latitude"] doubleValue];
        CLLocationDegrees longitude = [dictionary[@"longitude"] doubleValue];
        CGFloat speed = [dictionary[@"speed"] floatValue];
        NSNumber* acceleration = dictionary[@"acceleration"];
        NSDate* timestamp = [dictionary[@"timestamp"] toDateFromStringDate];
        BITripEntry *entry = [[BITripEntry alloc] init];
        entry->_coordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
        entry->_speed = speed;
        entry->_timestamp = timestamp;
        entry->_acceleration = acceleration;
        return entry;
    }
    return self;
}

- (CGFloat)speed {
    return _speed;
}


@end