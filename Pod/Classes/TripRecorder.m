#import "TripRecorder.h"
#import "Trip.h"

@import CoreLocation;


@implementation TripRecorder {
    CLLocationManager *_locationManager;
}

-(void) start{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"location updated!! %@", newLocation);
}

-(Trip *) stop {
    return [Trip new];
}

@end