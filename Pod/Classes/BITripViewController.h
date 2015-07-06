#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BITrip;

@protocol BITripViewControllerProtocol;
@interface BITripViewController : UIViewController
@property (nonatomic, weak) id<BITripViewControllerProtocol> delegate;
- (instancetype)initWithTrip:(BITrip *)trip;
@end

@protocol BITripViewControllerProtocol <NSObject>
- (void)tripViewController:(BITripViewController *)sender openPlaybackViewRequestedOnTrip:(BITrip *)trip;
@end