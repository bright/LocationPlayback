#import <LocationPlayback/BITripEntry.h>
#import "BIPlaybackPlayedEntry.h"


@implementation BIPlaybackPlayedEntry {
    NSDate *_playedAt;
    BITripEntry *_playedEntry;
}

- (instancetype)initWithPlayedAt:(NSDate *)playedAt playedEntry:(BITripEntry *)playedEntry {
    self = [super init];
    if (self) {
        _playedAt = playedAt;
        _playedEntry = playedEntry;
    }

    return self;
}

+ (instancetype)entryWithPlayedAt:(NSDate *)playedAt playedEntry:(BITripEntry *)playedEntry {
    return [[self alloc] initWithPlayedAt:playedAt playedEntry:playedEntry];
}

- (NSDate *)playedAt {
    return _playedAt;
}

- (BITripEntry *)playedEntry {
    return _playedEntry;
}


@end