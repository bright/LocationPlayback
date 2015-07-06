#import "BITripPreviewPresenter.h"
#import "BITrip.h"
#import "BITripPlayback.h"
#import "BITripPlaybackPreview.h"
#import "UIView+Additions.h"
#import "BILocationPlaybackConfiguration.h"
#import "BILocationPlayback.h"


@implementation BITripPreviewPresenter {
    BITripPlaybackPreview *_previewMap;
}

- (instancetype)initWithTrip:(BITrip *)trip {
    self = [super init];
    if (self) {
        [self setupPresenterWithTrip:trip];
    }

    return self;
}

- (void)setupPresenterWithTrip:(BITrip *)trip {
    _previewMap = [[BITripPlaybackPreview alloc] init];

    [self disableUserInteractionWithSubviews];
    [self setupPresenterGestures];

    BILocationPlaybackConfiguration *configuration = [[BILocationPlayback instance] getConfiguration];
    CGSize previewSize = configuration.previewSize;
    _previewMap.frame = CGRectMake(0, 0, previewSize.width, previewSize.height);
}

- (void)setupPresenterGestures {
    [self setupMoveGesture];
    [self setupRemovalFromSuperviewGesture];
}

- (void)setupRemovalFromSuperviewGesture {
    UITapGestureRecognizer *gestureRecognizer = [UITapGestureRecognizer new];
    gestureRecognizer.numberOfTapsRequired = 1;

    [_previewMap addRemovalFromSuperviewGesture:gestureRecognizer];
}

- (void)setupMoveGesture {
    UIPanGestureRecognizer *panGestureRecognizer = [UIPanGestureRecognizer new];
    [panGestureRecognizer setMinimumNumberOfTouches:1];
    [panGestureRecognizer setMaximumNumberOfTouches:1];
    [_previewMap addMoveGesture:panGestureRecognizer];
}

- (void)disableUserInteractionWithSubviews {
    for (UIView *view in [_previewMap subviews]) {
        view.userInteractionEnabled = NO;
    }
}

- (void)showOnView:(UIView *)view {
    [view addSubview:_previewMap];
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIView *presentersDestinationView = window.rootViewController.view;
    [self showOnView:presentersDestinationView];
}
@end