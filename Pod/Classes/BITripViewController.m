#import "BITripViewController.h"
#import "BITrip.h"
#import "BITripSummaryView.h"
#import "BIStyles.h"
#import "ALView+PureLayout.h"
#import "BITripMap.h"

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
    CGFloat itemWidth = self.view.frame.size.width - 2 * LEFT_RIGHT_INSET;

    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];

    [scrollView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];

    BITripSummaryView *tripSummaryView = [[BITripSummaryView alloc] initWithTrip:_trip];
    [BIStyles createRoundedBorderForView:tripSummaryView];
    [scrollView addSubview:tripSummaryView];

    UIButton *playbackButton = [BIStyles createButtonWithName:@"Playback"];
    [scrollView addSubview:playbackButton];
    [playbackButton addTarget:self action:@selector(_playback) forControlEvents:UIControlEventTouchUpInside];

    [tripSummaryView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:VERTICAL_SPACING];
    [tripSummaryView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [tripSummaryView autoSetDimension:ALDimensionWidth toSize:itemWidth];
    [tripSummaryView autoSetDimension:ALDimensionHeight toSize:TRIP_SUMMARY_VIEW_HEIGHT];

    [playbackButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tripSummaryView withOffset:VERTICAL_SPACING];
    [playbackButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [playbackButton autoSetDimension:ALDimensionWidth toSize:itemWidth];

    BITripMap *tripMap = [[BITripMap alloc] initWithTrip:_trip];
    [scrollView addSubview:tripMap];

    [tripMap autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:playbackButton withOffset:VERTICAL_SPACING];
    [tripMap autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [tripMap autoSetDimension:ALDimensionWidth toSize:itemWidth];
    [tripMap autoSetDimension:ALDimensionHeight toSize:200];

    [scrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:tripMap withOffset:VERTICAL_SPACING];

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