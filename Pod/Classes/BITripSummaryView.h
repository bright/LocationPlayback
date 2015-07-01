#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BIRecordedTripSummaryViewProtocol;
@class BITrip;

@interface BITripSummaryView : UIView

@property (nonatomic, weak) id<BIRecordedTripSummaryViewProtocol> delegate;
- (instancetype)initWithTrip:(BITrip *)trip;

@end

@protocol BIRecordedTripSummaryViewProtocol <NSObject>
@end