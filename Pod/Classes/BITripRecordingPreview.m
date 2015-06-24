#import "BITripRecordingPreview.h"
#import "BITripRecorder.h"
#import "BITripEntry.h"
#import "BITrip.h"

@import MapKit;

@implementation BITripRecordingPreview {
    __weak BITripRecorder* _tripRecorder;
    MKMapView *_mapView;
}

- (instancetype)initWithTripRecorder:(BITripRecorder *) tripRecorder {
    self = [super initWithFrame:CGRectMake(0, 0, 200, 200)];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        _tripRecorder = tripRecorder;
        _tripRecorder.delegate = self;
        [self addSubview: _mapView];
    }

    return self;
}

- (void)tripRecorder:(BITripRecorder *)recorder didRecordTripEntry:(BITripEntry *)entry {
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = [entry getCoordinate];
    [_mapView showAnnotations:@[myAnnotation] animated:YES];
}

- (void)tripRecorderDidStartRecording:(BITripRecorder *)recorder {

}

- (void)tripRecorder:(BITripRecorder *)recorder didStopRecordingTrip:(BITrip *)recorderTrip {

}


@end