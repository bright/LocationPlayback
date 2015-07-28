#import "BITripRecorder.h"
#import "BITripRecordingPreview.h"
#import "BISimpleTripRecorder.h"
#import "BITripEntry.h"
#import "BITrip.h"
#import "ALView+PureLayout.h"

@import MapKit;

@implementation BITripRecordingPreview {
    __weak id<BITripRecorder> _tripRecorder;
    MKMapView *_mapView;
}

- (instancetype)initWithTripRecorder:(id<BITripRecorder>)tripRecorder{
    self = [super init];
    if (self) {
        _mapView = [MKMapView new];
        _tripRecorder = tripRecorder;
        _tripRecorder.delegate = self;
        [self addSubview: _mapView];
        [_mapView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
    }

    return self;
}

- (void)tripRecorder:(id<BITripRecorder>)recorder didRecordTripEntry:(BITripEntry *)entry {
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = [entry getCoordinate];
    [_mapView showAnnotations:@[myAnnotation] animated:YES];
}

- (void)tripRecorderDidStartRecording:(id<BITripRecorder>)recorder {

}

- (void)tripRecorder:(id<BITripRecorder>)recorder didStopRecordingTrip:(BITrip *)recorderTrip {

}

- (void)clearAnnotations {
    [_mapView removeAnnotations:_mapView.annotations];
}


@end