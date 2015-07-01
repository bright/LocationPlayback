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
    NSString *_tripName;
}

- (instancetype)initWithTripName:(NSString *)tripName {
    self = [super init];
    if (self) {
        _tripName = tripName;
    }

    return self;
}

+ (instancetype)recorderWithTripName:(NSString *)tripName {
    return [[self alloc] initWithTripName:tripName];
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
    NSString *storageTripName = [self createTripName];
    NSDate *tripEndDate = [NSDate new];
    return [[BITrip alloc] initWithStartDate:_startDate endDate:tripEndDate entries:_tripEntries name:storageTripName];
}

- (NSString *)createTripName {
    NSDate *currentDate = [NSDate new];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yy HH:mm:ss";
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSString *storageTripName = [NSString stringWithFormat:@"%@ %@", _tripName, currentDateString];
    return storageTripName;
}

@end