#import "BITripMap.h"
#import "BITrip.h"
#import "PureLayoutDefines.h"
#import "ALView+PureLayout.h"
#import "BITripEntry.h"

@import MapKit;

@implementation BITripMap {
    BITrip *_trip;
    MKMapView *_mapView;
}

- (instancetype)initWithTrip:(BITrip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;
        [self setupView];
    }

    return self;
}

- (void)setupView {
    _mapView = [MKMapView new];
    [self addSubview: _mapView];
    [_mapView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];

    for (BITripEntry *entry in _trip.getEntries) {
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = [entry getCoordinate];
        [_mapView showAnnotations:@[myAnnotation] animated:YES];
    }
}


@end