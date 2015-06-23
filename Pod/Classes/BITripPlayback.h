#import <Foundation/Foundation.h>

@class BITrip;


@interface BITripPlayback : NSObject
- (instancetype)initWithTrip:(BITrip *)trip;

+ (instancetype)playbackWithTrip:(BITrip *)trip;


- (void)play;
@end