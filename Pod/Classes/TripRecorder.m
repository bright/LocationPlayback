#import "TripRecorder.h"
#import "Trip.h"
#import "TripEntry.h"

@import CoreLocation;


@implementation TripRecorder {
    CLLocationManager *_locationManager;
    NSMutableArray *_tripEntries;
    NSDate *_startDate;
    BOOL _recording;
}

- (void)start {
    NSLog(@"start recording trip");
    _startDate = [NSDate date];
    _tripEntries = [NSMutableArray new];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _recording = YES;
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if(_recording){
        NSLog(@"location updated!! %@", newLocation);
        TripEntry *entry = [[TripEntry alloc] initWithLocation: newLocation];
        NSLog(@"new trip entry created!! %@", entry);
        [_tripEntries addObject: entry];
    }
}

- (Trip *)stop {
    _recording = NO;
    [_locationManager stopUpdatingLocation];
    return [[Trip alloc] initWithStartDate:_startDate entries:_tripEntries];
}

@end