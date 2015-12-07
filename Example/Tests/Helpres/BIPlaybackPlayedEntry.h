#import <Foundation/Foundation.h>

@interface BIPlaybackPlayedEntry : NSObject
- (instancetype)initWithPlayedAt:(NSDate *)playedAt playedEntry:(BITripEntry *)playedEntry;

- (NSDate *)playedAt;

- (BITripEntry *)playedEntry;

+ (instancetype)entryWithPlayedAt:(NSDate *)playedAt playedEntry:(BITripEntry *)playedEntry;

@end