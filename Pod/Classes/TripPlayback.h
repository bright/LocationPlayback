#import <Foundation/Foundation.h>

@class Trip;


@interface TripPlayback : NSObject
- (instancetype)initWithTrip:(Trip *)trip;

+ (instancetype)playbackWithTrip:(Trip *)trip;


- (void)play;
@end