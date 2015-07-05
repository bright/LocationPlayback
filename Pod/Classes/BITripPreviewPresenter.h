#import <UIKit/UIKit.h>

@class BITrip;

@interface BITripPreviewPresenter : NSObject
- (instancetype)initWithTrip:(BITrip *)trip;

- (void)showOnView:(UIView *)view;

- (void)show;
@end