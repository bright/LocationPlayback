#import "BITripRecorder.h"
#import "BITrip.h"
#import "BITripEntry.h"

@import CoreLocation;


@implementation BITripRecorder {
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
        BITripEntry *entry = [[BITripEntry alloc] initWithLocation: newLocation];
        NSLog(@"new trip entry created!! %@", entry);
        [_tripEntries addObject: entry];
    }
}

- (BITrip *)stop {
    _recording = NO;
    [_locationManager stopUpdatingLocation];
    return [[BITrip alloc] initWithStartDate:_startDate entries:_tripEntries name:[[NSUUID UUID] UUIDString]];
}

@end