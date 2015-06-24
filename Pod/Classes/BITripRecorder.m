#import "BITripRecorder.h"
#import "BITrip.h"
#import "BITripEntry.h"

@import CoreLocation;


@implementation BITripRecorder {
    CLLocationManager *_locationManager;
    NSMutableArray *_tripEntries;
    NSDate *_startDate;
    BOOL _recording;
    NSTimeInterval _lastLocationTimeInterval;
}

- (void)start {
    NSLog(@"start recording trip");
    _lastLocationTimeInterval = 0;
    _startDate = [NSDate date];
    _lastLocationTimeInterval = [_startDate timeIntervalSince1970];
    _tripEntries = [NSMutableArray new];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _recording = YES;
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if(_recording){
        if([newLocation.timestamp timeIntervalSince1970] <= _lastLocationTimeInterval) return;

        _lastLocationTimeInterval = [newLocation.timestamp timeIntervalSince1970];
        NSLog(@"location updated!! %@", newLocation);
        BITripEntry *entry = [[BITripEntry alloc] initWithLocation: newLocation];
        NSLog(@"new trip entry created!! %@", entry);
        [self.delegate tripRecorder:self didRecordTripEntry: entry];
        [_tripEntries addObject: entry];
    }
}

- (BITrip *)stop {
    _recording = NO;
    [_locationManager stopUpdatingLocation];
    return [[BITrip alloc] initWithStartDate:_startDate entries:_tripEntries name:[[NSUUID UUID] UUIDString]];
}

@end