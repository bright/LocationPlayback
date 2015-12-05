#import <Foundation/Foundation.h>

@class BITrip;

@protocol BILocationPlaybackMainViewControllerProtocol <NSObject>

- (void)userRequestedTripPlaybackOnTrip:(BITrip *)trip withSpeedMultiplier:(double)multiplier;

- (void)userRequestedStopPlaybackOnTrip:(BITrip *)trip;

@end