#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BIRecordedTripSummaryViewProtocol;
@class BITrip;

@interface BIRecordedTripSummaryView : UIView
@property (nonatomic, weak) id<BIRecordedTripSummaryViewProtocol> delegate;
- (instancetype)initWithFrame:(CGRect)rect trip:(BITrip *)trip;
@end

@protocol BIRecordedTripSummaryViewProtocol <NSObject>
@end