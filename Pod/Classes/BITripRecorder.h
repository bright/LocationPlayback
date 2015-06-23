#import <Foundation/Foundation.h>

@protocol CLLocationManagerDelegate;
@class BITrip;

@interface BITripRecorder : NSObject <CLLocationManagerDelegate>
- (void)start;

- (BITrip *)stop;
@end