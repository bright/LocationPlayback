#import <LocationPlayback/BITripEntry.h>
#import "BIFakePlaybackProtocolImplementation.h"
#import "BIPlaybackPlayedEntry.h"


@implementation BIFakePlaybackProtocolImplementation {
    NSMutableArray *_playedEntries;
    BOOL _tripEndedWasCalled;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _playedEntries = [NSMutableArray new];
    }
    return self;
}


- (void)tripPlaybackEnded:(BITripPlayback *)playback {
    _tripEndedWasCalled = YES;
    _onTripEnded();
    NSLog(@"trip playback - ended");
}

- (void)tripPlayback:(BITripPlayback *)playback playEntry:(BITripEntry *)entry {
    @synchronized (_playedEntries) {
        [_playedEntries addObject:[BIPlaybackPlayedEntry entryWithPlayedAt:[NSDate date] playedEntry:entry]];
    }
}

- (void)tripPlaybackStarted:(BITripPlayback *)playback {
    NSLog(@"trip playback - started");
}

-(NSArray *)playedEntries {
    return [_playedEntries copy];
}

-(BOOL)tripWasEnded {
    return _tripEndedWasCalled;
}

@end