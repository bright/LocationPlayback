#import "BITripPlaybackPreview.h"
#import "BITripPlayback.h"
#import "BITripEntry.h"
#import "ALView+PureLayout.h"

@import MapKit;

@implementation BITripPlaybackPreview {
    __weak BITripPlayback* _tripPlayback;
    MKMapView *_mapView;
}

- (instancetype)initWithTripPlayback:(__weak BITripPlayback *)tripPlayback {
    self = [super init];
    if (self) {
        _mapView = [MKMapView new];

        _tripPlayback = tripPlayback;
        _tripPlayback.delegate = self;
        [self addSubview: _mapView];
        [_mapView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
    }

    return self;
}

+ (instancetype)previewWithTripPlayback:(__weak BITripPlayback *)tripPlayback {
    return [[self alloc] initWithTripPlayback:tripPlayback];
}

- (void)tripPlaybackEnded:(BITripPlayback *)playback {

}

- (void)tripPlayback:(BITripPlayback *)playback playEntry:(BITripEntry *)entry {
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = [entry getCoordinate];
    [_mapView showAnnotations:@[myAnnotation] animated:YES];
}

- (void)tripPlaybackStarted:(BITripPlayback *)playback {

}

- (void)clearAnnotations {
    [_mapView removeAnnotations:_mapView.annotations];
}

@end