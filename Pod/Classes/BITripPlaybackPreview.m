#import "BITripPlaybackPreview.h"
#import "BITripPlayback.h"
#import "BITripEntry.h"
#import "ALView+PureLayout.h"
#import "BILocationPlayback.h"

@import MapKit;

@implementation BITripPlaybackPreview {
    MKMapView *_mapView;
    NSMutableArray *_annotations;
    BILocationPlayback *_locationPlayback;
    MKPointAnnotation *_lastAnnotation;
    NSTimer *_everySecondTimer;
    UITextView *_infoView;
    NSDateFormatter *_dateFormatter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _mapView = [MKMapView new];
        _annotations = [NSMutableArray new];
        _locationPlayback = [BILocationPlayback instance];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tripUpdated:) name:[_locationPlayback tripUpdateNotification] object:_locationPlayback];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tripStarted:) name:[_locationPlayback tripStartedNotification] object:_locationPlayback];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tripEnded:) name:[_locationPlayback tripEndedNotification] object:_locationPlayback];
        [self addSubview:_mapView];
        _infoView = [[UITextView alloc] init];
        [self addSubview:_infoView];
        [_infoView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
        [_infoView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
        [_infoView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
        [_infoView autoSetDimension:ALDimensionWidth toSize:160];
        _infoView.textAlignment = NSTextAlignmentRight;
        _infoView.backgroundColor = [UIColor clearColor];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [_mapView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
    }
    return self;
}

- (void)tripEnded:(NSNotification *)notification {
    [_everySecondTimer invalidate];
    _everySecondTimer = nil;
}

- (void)tripStarted:(NSNotification *)notification {
    [self removeAllAnnotations];
    [self startEverySecondTimer];
}

- (void)startEverySecondTimer {
    [_everySecondTimer invalidate];
    _everySecondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(everySecond) userInfo:nil repeats:YES];
}

- (void)everySecond {
    [self showLastAnnotation];
}

- (void)removeAllAnnotations {
    [_mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
}

- (void)tripUpdated:(NSNotification *)notification {
    if (_everySecondTimer == nil) {
        [self startEverySecondTimer];
    }
    BITripEntry *entry = [_locationPlayback getTripEntryFromUserInfo:notification.userInfo];
    NSDate *tripDate = [_locationPlayback getTripDate];
    NSMutableString *info = [NSMutableString new];
    if (tripDate) {
        [info appendString:[NSString stringWithFormat:@"%@\n", [_dateFormatter stringFromDate:tripDate]]];
    }
    [info appendString:[NSString stringWithFormat:@"%.2f m/s\n", entry.speed]];
    if (entry.acceleration) {
        [info appendString:[NSString stringWithFormat:@"%.2f m/sec2", [entry.acceleration floatValue]]];
    }
    _infoView.text = info;
    [self onMapMarkTripEntry:entry];
}

- (void)onMapMarkTripEntry:(BITripEntry *)entry {
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = [entry getCoordinate];
    [_annotations addObject:myAnnotation];
    [_mapView addAnnotation:myAnnotation];
    _lastAnnotation = myAnnotation;
}

- (void)showLastAnnotation {
    if (_lastAnnotation) {
        [_mapView showAnnotations:@[_lastAnnotation] animated:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end