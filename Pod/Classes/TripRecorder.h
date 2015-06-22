#import <Foundation/Foundation.h>

@protocol CLLocationManagerDelegate;
@class Trip;

@interface TripRecorder : NSObject <CLLocationManagerDelegate>
- (void)start;

- (Trip *)stop;
@end