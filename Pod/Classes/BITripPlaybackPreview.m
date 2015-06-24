#import "BITripPlaybackPreview.h"
#import "BITripPlayback.h"
#import "BITripEntry.h"

@import MapKit;

@implementation BITripPlaybackPreview {
    __weak BITripPlayback* _tripPlayback;
    MKMapView *_mapView;
}

- (instancetype)initWithTripPlayback:(__weak BITripPlayback *)tripPlayback {
    self = [super init];
    if (self) {
        _tripPlayback = tripPlayback;
        self.backgroundColor = [UIColor redColor];
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        _tripPlayback.delegate = self;
        [self addSubview: _mapView];
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


@end