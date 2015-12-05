#import <Foundation/Foundation.h>

@class BITrip;

@protocol BILocationPlaybackMainViewControllerProtocol <NSObject>

- (void)userRequestedTripPlaybackOnTrip:(BITrip *)trip;

- (void)userRequestedStopPlaybackOnTrip:(BITrip *)trip;

@end