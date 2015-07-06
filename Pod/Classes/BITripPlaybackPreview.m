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
        [_mapView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
    }
    return self;
}

- (void)tripEnded:(NSNotification *)notification {

}

- (void)tripStarted:(NSNotification *)notification {
    [_mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
}

- (void)tripUpdated:(NSNotification *)notification {
    BITripEntry *entry = [_locationPlayback getTripEntryFromUserInfo:notification.userInfo];
    [self onMapMarkTripEntry:entry];
}

- (void)onMapMarkTripEntry:(BITripEntry *)entry {
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = [entry getCoordinate];
    [_annotations addObject:myAnnotation];
    [_mapView showAnnotations:@[myAnnotation] animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end