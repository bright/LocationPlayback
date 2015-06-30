#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BITripsViewController.h"
#import "BILocationPlaybackPreviewViewController.h"
#import "BILocationRecordingViewController.h"
#import "BITripViewController.h"


@interface BILocationPlaybackMainViewController : UIViewController <BITripsViewControllerProtocol, BILocationPlaybackPreviewViewControllerProtocol, BILocationRecordingViewControllerProtocol, BITripViewControllerProtocol>

- (void)showTripsViewController:(NSArray *)array;
@end