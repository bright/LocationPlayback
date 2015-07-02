#import "BITripPlaybackPreview.h"
#import "BITripPlayback.h"
#import "BITripEntry.h"
#import "ALView+PureLayout.h"

@import MapKit;

@implementation BITripPlaybackPreview {
    __weak BITripPlayback *_tripPlayback;
    MKMapView *_mapView;
}

- (instancetype)initWithTripPlayback:(__weak BITripPlayback *)tripPlayback gesturesEnabled:(BOOL)gesturesEnabled {
    self = [super init];
    if (self) {
        _mapView = [MKMapView new];
        _tripPlayback = tripPlayback;
        _tripPlayback.delegate = self;
        [self addSubview:_mapView];
        [_mapView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];

        self.gesturesEnabled = gesturesEnabled;
        [self setupGesturesIfEnabled];

    }

    return self;
}

- (void)setupGesturesIfEnabled {
    if (self.gesturesEnabled) {
        _mapView.userInteractionEnabled = NO;

        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        [panGestureRecognizer setMinimumNumberOfTouches:1];
        [panGestureRecognizer setMaximumNumberOfTouches:1];
        [self addGestureRecognizer:panGestureRecognizer];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }

}

- (void)tapGestureAction {
    [self removeFromSuperview];
}

- (void)move:(UIPanGestureRecognizer *)sender {
    self.center = [sender locationInView:self.superview];
}

+ (instancetype)previewWithTripPlayback:(__weak BITripPlayback *)tripPlayback {
    return [[self alloc] initWithTripPlayback:tripPlayback gesturesEnabled:NO];
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