#import <Foundation/Foundation.h>

@class BITripPlayback;
@class BITripEntry;

@protocol BITripPlaybackProtocol <NSObject>

- (void)tripPlaybackEnded:(BITripPlayback *)playback;

- (void)tripPlayback:(BITripPlayback *)playback playEntry:(BITripEntry *)entry;

- (void)tripPlaybackStarted:(BITripPlayback *)playback;

@end