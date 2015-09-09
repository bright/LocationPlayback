#import <Foundation/Foundation.h>
#import <LocationPlayback/BITripPlayback.h>


@interface BIFakePlaybackProtocolImplementation : NSObject<BITripPlaybackProtocol>
@property(nonatomic, copy) void (^onTripEnded)();

- (NSArray *)playedEntries;

- (BOOL)tripWasEnded;
@end