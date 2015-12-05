#import <Foundation/Foundation.h>

@class BITrip;

@protocol BITripPlaybackProtocol;
@class BITripEntry;

@interface BITripPlayback : NSObject

@property(nonatomic, weak) id <BITripPlaybackProtocol> delegate;

- (instancetype)initWithTrip:(BITrip *)trip;

+ (instancetype)playbackWithTrip:(BITrip *)trip;

- (void)stopRequested;

- (void)play;

-(BITrip *) getTrip;

@end