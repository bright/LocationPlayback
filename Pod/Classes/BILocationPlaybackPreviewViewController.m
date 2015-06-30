#import "BILocationPlaybackPreviewViewController.h"
#import "BITrip.h"
#import "BITripPlayback.h"
#import "BITripPlaybackPreview.h"
#import "BITripEntry.h"


@implementation BILocationPlaybackPreviewViewController {
    BITrip *_trip;
    BITripPlayback *_playback;
    BITripPlaybackPreview *_playbackPreview;
    BITripPlayback *_playbackForPreview;
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

    [self startPreview];
}

- (void)startPreview {
    _playback = [[BITripPlayback alloc] initWithTrip:_trip];
    _playback.delegate = self;
    _playbackForPreview = [[BITripPlayback alloc] initWithTrip:_trip];
    _playbackPreview = [[BITripPlaybackPreview alloc] initWithTripPlayback:_playbackForPreview];
    [self.view addSubview:_playbackPreview];

    [_playback play];
    [_playbackForPreview play];
}

- (void)tripPlaybackEnded:(BITripPlayback *)playback {
    [self.delegate playbackPreviewVC:self onPlaybackEndedForTrip: _trip];
}

- (void)tripPlayback:(BITripPlayback *)playback playEntry:(BITripEntry *)entry {

}

- (void)tripPlaybackStarted:(BITripPlayback *)playback {

}


@end