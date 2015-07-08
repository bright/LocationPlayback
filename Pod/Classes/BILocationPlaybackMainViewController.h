#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BITripsViewController.h"
#import "BILocationPlaybackPreviewViewController.h"
#import "BILocationRecordingViewController.h"
#import "BITripViewController.h"

@protocol BILocationPlaybackMainViewControllerProtocol;

@interface BILocationPlaybackMainViewController : UIViewController <BITripsViewControllerProtocol, BILocationPlaybackPreviewViewControllerProtocol, BILocationRecordingViewControllerProtocol, BITripViewControllerProtocol>
@property (nonatomic, weak) id<BILocationPlaybackMainViewControllerProtocol> delegate;

- (void)showTripsViewController:(NSArray *)trips allowDelete:(BOOL)allowDelete;

@end

@protocol BILocationPlaybackMainViewControllerProtocol <NSObject>

- (void)userRequestedTripPlaybackOnTrip:(BITrip *)trip;

- (void)userRequestedStopPlaybackOnTrip:(BITrip *)trip;

@end