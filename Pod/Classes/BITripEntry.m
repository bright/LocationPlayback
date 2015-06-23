#import "BITripEntry.h"

@import CoreLocation;

#import <CoreGraphics/CoreGraphics.h>

@interface BITripEntry ()

@property(nonatomic) CLLocationCoordinate2D coordinate2D;
@property(nonatomic) CGFloat speed;
@property(nonatomic, strong) NSDate *timestamp;

@end

@implementation BITripEntry {
}

- (instancetype)initWithLocation: (CLLocation *) location {
    self = [super init];
    if (self) {
        self.coordinate2D = location.coordinate;
        self.speed = (CGFloat) location.speed;
        self.timestamp = location.timestamp;
    }
    return self;
}

- (NSDate *)getTimestamp {
    return _timestamp;
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
    if (self.timestamp != entry.timestamp && ![self.timestamp isEqualToDate:entry.timestamp])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [[NSNumber numberWithDouble:self.coordinate2D.latitude] hash];
    hash = hash * 31u + [[NSNumber numberWithDouble:self.coordinate2D.longitude] hash];
    hash = hash * 31u + [[NSNumber numberWithDouble:self.speed] hash];
    hash = hash * 31u + [self.timestamp hash];
    return hash;
}


@end