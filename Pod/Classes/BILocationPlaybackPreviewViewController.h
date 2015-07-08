#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BILocationPlaybackPreviewViewControllerProtocol;
@class BITrip;
@protocol BITripPlaybackProtocol;

@interface BILocationPlaybackPreviewViewController : UIViewController
@property (nonatomic, weak) id<BILocationPlaybackPreviewViewControllerProtocol> delegate;

- (instancetype)initWithTrip:(BITrip *)trip;

@end

@protocol BILocationPlaybackPreviewViewControllerProtocol <NSObject>

- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller tripPlaybackStartRequested:(BITrip *)requested;

- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller tripPlaybackStopRequested:(BITrip *)requested;

@end