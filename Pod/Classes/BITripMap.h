#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class BITrip;

@interface BITripMap : UIView
- (instancetype)initWithTrip:(BITrip *)trip;

+ (instancetype)mapWithTrip:(BITrip *)trip;


@end