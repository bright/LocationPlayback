#import "TripEntry.h"

@import CoreLocation;

#import <CoreGraphics/CoreGraphics.h>

@interface TripEntry ()

@property(nonatomic) CLLocationCoordinate2D coordinate2D;
@property(nonatomic) CGFloat speed;
@property(nonatomic, strong) NSDate *timestamp;

@end

@implementation TripEntry {
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


@end