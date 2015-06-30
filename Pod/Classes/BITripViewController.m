#import "BITripViewController.h"
#import "BITrip.h"
#import "BITripPlaybackPreview.h"
#import "BITripSummaryView.h"


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

    BITripSummaryView *tripSummaryView = [[BITripSummaryView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300) trip:_trip];
    [self.view addSubview:tripSummaryView];

    UIButton *playbackButton = [self createPlaybackButton];
    [self.view addSubview:playbackButton];
    playbackButton.frame = CGRectMake(0, tripSummaryView.frame.origin.y + tripSummaryView.frame.size.height + 20, playbackButton.frame.size.width, playbackButton.frame.size.height);
    [playbackButton addTarget:self action:@selector(_playback) forControlEvents:UIControlEventTouchUpInside];

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