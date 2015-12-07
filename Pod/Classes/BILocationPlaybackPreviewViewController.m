#import "BITripPlayback.h"
#import "BILocationPlaybackPreviewViewController.h"
#import "BITrip.h"
#import "BITripPlaybackPreview.h"
#import "BITripEntry.h"
#import "ALView+PureLayout.h"
#import "BIStyles.h"
#import "BILocationPlayback.h"

#define VERTICAL_SPACING 10
#define LEFT_RIGHT_INSET 20
#define BUTTON_HEIGHT 75
#define PREVIEW_HEIGHT 150

@implementation BILocationPlaybackPreviewViewController {
    BITrip *_trip;
    BITripPlaybackPreview *_playbackPreview;
    UIButton *_playButton;
    UILabel *_speedLabel;
    UILabel *_longitudeLabel;
    UILabel *_latitudeLabel;
    UIButton *_stopButton;
    BILocationPlayback *_locationPlayback;
    UILabel *_speedMultiplierLabel;
    UILabel *_dateLabel;
    UISlider *_speedMultiplierSlider;
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

    UIBarButtonItem *hideBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hide" style:UIBarButtonItemStyleDone target:self action:@selector(hideAction)];
    self.navigationItem.rightBarButtonItem = hideBarButtonItem;

    _playbackPreview = [[BITripPlaybackPreview alloc] init];
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

    _stopButton = [BIStyles createButtonWithName:@"Stop"];
    [_stopButton addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_stopButton];

    [_stopButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_playbackPreview withOffset:VERTICAL_SPACING];
    [_stopButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [_stopButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [_stopButton autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];

    _speedMultiplierLabel = [[UILabel alloc] init];
    [self.view addSubview:_speedMultiplierLabel];

    [_speedMultiplierLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_playButton];
    [_speedMultiplierLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_playButton];
    [_speedMultiplierLabel autoSetDimension:ALDimensionWidth toSize:250];
    [_speedMultiplierLabel autoSetDimension:ALDimensionHeight toSize:40];

    _speedMultiplierSlider = [[UISlider alloc] init];
    _speedMultiplierSlider.minimumValue = 0.2;
    _speedMultiplierSlider.maximumValue = 30;
    _speedMultiplierSlider.value = 1;
    [_speedMultiplierSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_speedMultiplierSlider];
    [_speedMultiplierSlider autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_speedMultiplierLabel];
    [_speedMultiplierSlider autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_playButton];
    [_speedMultiplierSlider autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_playButton];

    _speedMultiplierLabel.text = [self getSpeedMultiplierString:_speedMultiplierSlider.value];

    _speedLabel = [UILabel new];
    _speedLabel.text = @"Speed: ";
    [self.view addSubview:_speedLabel];
    [_speedLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_speedMultiplierSlider withOffset:VERTICAL_SPACING];
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

    _dateLabel = [UILabel new];
    _dateLabel.text = @"Date: ";
    [self.view addSubview:_dateLabel];

    [_dateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_latitudeLabel withOffset:VERTICAL_SPACING];
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];

    _locationPlayback = [BILocationPlayback instance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tripUpdated:) name:[_locationPlayback tripUpdateNotification] object:_locationPlayback];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tripStarted:) name:[_locationPlayback tripStartedNotification] object:_locationPlayback];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tripEnded:) name:[_locationPlayback tripEndedNotification] object:_locationPlayback];

    _stopButton.hidden = ![_locationPlayback isTripPlaybackPlaying];
    _playButton.hidden = [_locationPlayback isTripPlaybackPlaying];
}

- (NSString *)getSpeedMultiplierString:(double)speedMultiplier {
    return [NSString stringWithFormat:@"Speed multiplier: %.1fx", speedMultiplier];
}

- (void)sliderValueChanged:(UISlider *)sender {
    if (_speedMultiplierSlider == sender) {
        _speedMultiplierLabel.text = [self getSpeedMultiplierString:sender.value];
    }
}

- (double)getSpeedMultiplier {
    double speedMultiplier = _speedMultiplierSlider.value;
    return speedMultiplier == 0 ? 1 : speedMultiplier;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_trip == [_locationPlayback getPlayedTrip]) {
        [self turnPlaybackOnMode];
    } else {
        [self turnPlaybackOffMode];
    }
}

- (void)stopAction {
    [self.delegate playbackPreviewVC:self tripPlaybackStopRequested:_trip];
}

- (void)hideAction {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)playAction {
    [self.delegate playbackPreviewVC:self tripPlaybackStartRequested:_trip withSpeedMultiplier:[self getSpeedMultiplier]];
}

- (void)tripEnded:(NSNotification *)notification {
    [self turnPlaybackOffMode];
}

- (void)tripStarted:(NSNotification *)notification {
    [self turnPlaybackOnMode];
}

- (void)turnPlaybackOnMode {
    _playButton.hidden = YES;
    _stopButton.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
}

- (void)turnPlaybackOffMode {
    _playButton.hidden = NO;
    _stopButton.hidden = YES;
    self.navigationItem.hidesBackButton = NO;
}

- (void)tripUpdated:(NSNotification *)notification {
    BITripEntry *entry = [_locationPlayback getTripEntryFromUserInfo:notification.userInfo];
    _speedLabel.text = [NSString stringWithFormat:@"Speed: %.02f", entry.speed];
    _longitudeLabel.text = [NSString stringWithFormat:@"Longitude: %f", entry.getCoordinate.longitude];
    _latitudeLabel.text = [NSString stringWithFormat:@"Latitude: %f", entry.getCoordinate.latitude];
    _dateLabel.text = [NSString stringWithFormat:@"Date: %@", [[_locationPlayback getTripDate] description]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end