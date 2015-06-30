#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BILocationPlaybackPreviewViewControllerProtocol;
@class BITrip;
@protocol BITripPlaybackProtocol;

@interface BILocationPlaybackPreviewViewController : UIViewController <BITripPlaybackProtocol>
@property (nonatomic, weak) id<BILocationPlaybackPreviewViewControllerProtocol> delegate;

- (instancetype)initWithTrip:(BITrip *)trip;
@end

@protocol BILocationPlaybackPreviewViewControllerProtocol <NSObject>
- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller onPlaybackEndedForTrip:(BITrip *)trip;
@end