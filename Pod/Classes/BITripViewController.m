#import "BITripViewController.h"
#import "BITrip.h"
#import "BITripPlaybackPreview.h"
#import "BITripSummaryView.h"
#import "BIStyles.h"
#import "ALView+PureLayout.h"


#define LEFT_RIGHT_INSET 20
#define VERTICAL_SPACING 20
#define TRIP_SUMMARY_VIEW_HEIGHT 300

@implementation BITripViewController {

    BITrip *_trip;
}

- (instancetype)initWithTrip:(BITrip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;

    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.title = [_trip getName];

    self.view.backgroundColor = [UIColor whiteColor];

    BITripSummaryView *tripSummaryView = [[BITripSummaryView alloc] initWithTrip:_trip];
    [BIStyles createRoundedBorderForView:tripSummaryView];
    [self.view addSubview:tripSummaryView];

    UIButton *playbackButton = [BIStyles createButtonWithName:@"Playback"];
    [self.view addSubview:playbackButton];
    [playbackButton addTarget:self action:@selector(_playback) forControlEvents:UIControlEventTouchUpInside];

    [tripSummaryView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [tripSummaryView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [tripSummaryView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [tripSummaryView autoSetDimension:ALDimensionHeight toSize:TRIP_SUMMARY_VIEW_HEIGHT];

    [playbackButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tripSummaryView withOffset:VERTICAL_SPACING];
    [playbackButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [playbackButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];

}

- (void)_playback {
    [self.delegate tripViewController:self playbackRequestedOnTrip: _trip];
}

- (UIButton *)createPlaybackButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Playback" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 200, 70);
    return button;
}


@end