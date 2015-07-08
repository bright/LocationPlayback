#import "BITripPlayback.h"
#import "BILocationPlaybackMainViewController.h"
#import "BILocationPlayback.h"
#import "BILocationPlaybackConfiguration.h"
#import "BITrip.h"
#import "BITripPreviewPresenter.h"
#import "BITripEntry.h"

@implementation BILocationPlayback {
    BILocationPlaybackMainViewController *_locationPlaybackMainVC;
    BILocationPlaybackConfiguration *_configuration;
    BITripPlayback *_tripPlayback;
}

- (NSString *)tripStartedNotification {
    static NSString *startNotification = @"BILocationPlaybackTripStarted_notification";
    return startNotification;
}

- (NSString *)tripEndedNotification {
    static NSString *notification = @"BILocationPlaybackTripEnded_notification";
    return notification;
}

- (NSString *)tripUpdateNotification {
    static NSString *notification = @"BILocationPlaybackTripUpdate_notification";
    return notification;
}

- (BOOL)isTripPlaybackPlaying {
    return _tripPlayback != nil;
}

-(BITrip *) getPlayedTrip {
    return _tripPlayback != nil ? [_tripPlayback getTrip] : nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _configuration = [BILocationPlaybackConfiguration new];
    }
    return self;
}


+ (BILocationPlayback *)instance {
    static BILocationPlayback *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (void)show {
    UIWindow *window = [self getWindow];
    _locationPlaybackMainVC = [[BILocationPlaybackMainViewController alloc] init];
    _locationPlaybackMainVC.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_locationPlaybackMainVC];
    [window.rootViewController presentViewController:navigationController animated:YES completion:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(closeLocationPlaybackVC:)];
    _locationPlaybackMainVC.navigationItem.rightBarButtonItem = doneButton;

}

- (void)showMiniMapPlayback {
    BITrip *trip = [[BITrip alloc] initWithStartDate:[NSDate date] endDate:nil entries:nil name:@"test"];
    BITripPreviewPresenter *previewPresenter = [[BITripPreviewPresenter alloc] initWithTrip:trip];
    [previewPresenter show];
}

- (UIWindow *)getWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return window;
}

- (void)closeLocationPlaybackVC:(id)closeLocationPlaybackVC {
    [self hide];
}

- (void)hide {
    UIWindow *window = [self getWindow];
    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (BILocationPlaybackConfiguration *)getConfiguration {
    return _configuration;
}

- (void)userRequestedTripPlaybackOnTrip:(BITrip *)trip {
    _tripPlayback = [[BITripPlayback alloc] initWithTrip:trip];
    _tripPlayback.delegate = self;
    [_tripPlayback play];
}

- (void)userRequestedStopPlaybackOnTrip:(BITrip *)trip {
    [_tripPlayback stopRequested];
}

- (void)tripPlaybackEnded:(BITripPlayback *)playback {
    NSDictionary *userInfo = [self createUserInfoForTrip: [playback getTrip]];
    [[NSNotificationCenter defaultCenter] postNotificationName:[self tripEndedNotification]
                                                        object:self
                                                      userInfo:userInfo];
    _tripPlayback = nil;
}

- (void)tripPlayback:(BITripPlayback *)playback playEntry:(BITripEntry *)entry {
    NSDictionary *userInfo = [self createUserInfoForEntry:entry];
    [[NSNotificationCenter defaultCenter] postNotificationName:[self tripUpdateNotification]
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)tripPlaybackStarted:(BITripPlayback *)playback {
    NSDictionary *userInfo = [self createUserInfoForTrip: [playback getTrip]];
    [[NSNotificationCenter defaultCenter] postNotificationName:[self tripStartedNotification]
                                                        object:self
                                                      userInfo:userInfo];
}

- (NSDictionary *)createUserInfoForEntry:(BITripEntry *)entry {
    NSDictionary *userInfo = @{@"entry" : entry};
    return userInfo;
}

- (NSDictionary *)createUserInfoForTrip:(BITrip *)trip {
    NSDictionary *userInfo = @{@"trip" : trip};
    return userInfo;
}

- (BITrip *)getTripFromUserInfo:(NSDictionary *) userInfo{
    BITrip* trip = userInfo[@"trip"];
    return trip;
}

- (BITripEntry *)getTripEntryFromUserInfo:(NSDictionary *) userInfo{
    BITripEntry* trip = userInfo[@"entry"];
    return trip;
}

@end