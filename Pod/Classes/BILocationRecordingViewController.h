#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BITripSummaryView.h"

@protocol BILocationRecordingViewControllerProtocol;
@class BITrip;

@interface BILocationRecordingViewController : UIViewController <BIRecordedTripSummaryViewProtocol, UITextFieldDelegate>
@property (nonatomic, weak) id<BILocationRecordingViewControllerProtocol> delegate;
@end

@protocol BILocationRecordingViewControllerProtocol <NSObject>
- (void)recordingVC:(BILocationRecordingViewController *)sender tripRecorded:(BITrip *)recorded;
@end