#import "BILocationPlaybackPreviewViewController.h"
#import "BITrip.h"
#import "BITripPlayback.h"
#import "BITripPlaybackPreview.h"
#import "BITripEntry.h"
#import "ALView+PureLayout.h"
#import "BIStyles.h"

#define VERTICAL_SPACING 20
#define LEFT_RIGHT_INSET 20
#define BUTTON_HEIGHT 75
#define PREVIEW_HEIGHT 150

@implementation BILocationPlaybackPreviewViewController {
    BITrip *_trip;
    BITripPlayback *_playback;
    BITripPlaybackPreview *_playbackPreview;
    BITripPlayback *_playbackForPreview;

    UIButton *_playButton;
    UILabel *_speedLabel;
    UILabel *_longitudeLabel;
    UILabel *_latitudeLabel;
}
- (instancetype)initWithTrip:(BITrip *)trip {
    self = [super init];
    if(self){
        _trip = trip;
    }
    return self;
}

- (void)loadView {
    [super loadView];

    self.title = [_trip getName];
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *hideBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hide" style:UIBarButtonItemStyleDone target:self action:@selector(hideAction)];
    self.navigationItem.rightBarButtonItem = hideBarButtonItem;

    _playback = [[BITripPlayback alloc] initWithTrip:_trip];
    _playback.delegate = self;
    _playbackForPreview = [[BITripPlayback alloc] initWithTrip:_trip];
    _playbackPreview = [[BITripPlaybackPreview alloc] initWithTripPlayback:_playbackForPreview];
    [self.view addSubview:_playbackPreview];

    [_playbackPreview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [_playbackPreview autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_playbackPreview autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_playbackPreview autoSetDimension:ALDimensionHeight toSize:PREVIEW_HEIGHT];

    _playButton = [BIStyles createButtonWithName:@"Play"];
    [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];

    [_playButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_playbackPreview withOffset:VERTICAL_SPACING];
    [_playButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [_playButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [_playButton autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];

    _speedLabel = [UILabel new];
    _speedLabel.text = @"Speed: ";
    [self.view addSubview:_speedLabel];

    [_speedLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_playButton withOffset:VERTICAL_SPACING];
    [_speedLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];

    _longitudeLabel = [UILabel new];
    _longitudeLabel.text = @"Longitude: ";
    [self.view addSubview:_longitudeLabel];

    [_longitudeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_speedLabel withOffset:VERTICAL_SPACING];
    [_longitudeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];

    _latitudeLabel = [UILabel new];
    _latitudeLabel.text = @"Latitude: ";
    [self.view addSubview:_latitudeLabel];

    [_latitudeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_longitudeLabel withOffset:VERTICAL_SPACING];
    [_latitudeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
}

- (void)hideAction {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)playAction {
    [self startPreview];
}

- (void)startPreview {
    [_playback play];
    [_playbackForPreview play];
}

- (void)tripPlaybackEnded:(BITripPlayback *)playback {
}

- (void)tripPlayback:(BITripPlayback *)playback playEntry:(BITripEntry *)entry {
    _speedLabel.text = [NSString stringWithFormat:@"Speed: %.02f", entry.speed];
    _longitudeLabel.text = [NSString stringWithFormat:@"Longitude: %f", entry.getCoordinate.longitude];
    _latitudeLabel.text = [NSString stringWithFormat:@"Latitude: %f", entry.getCoordinate.latitude];
}

- (void)tripPlaybackStarted:(BITripPlayback *)playback {
}


@end