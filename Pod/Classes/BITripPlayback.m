#import "BITripPlayback.h"
#import "BITrip.h"
#import "BITripEntry.h"


@implementation BITripPlayback {
    BITrip *_trip;
    NSTimer *_timer;
    NSDate *_lastDate;
    NSDate *_startDate;
    NSArray *_tripEntries;
    NSEnumerator *_entriesEnumerator;
    BITripEntry *_entryToPlay;
    BOOL _play;
}

- (instancetype)initWithTrip:(BITrip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;
        _startDate = [trip getStartDate];
        _lastDate = _startDate;
        _tripEntries = [trip getEntries];
    }
    return self;
}

+ (instancetype)playbackWithTrip:(BITrip *)trip {
    return [[self alloc] initWithTrip:trip];
}

- (void)stopRequested {
    if (_play) {
        [self endTrip];
    }
}

- (void)play {
    _play = YES;
    [self.delegate tripPlaybackStarted:self];
    if ([_tripEntries count] == 0) {
        [self endTrip];
    }
    _entriesEnumerator = [_tripEntries objectEnumerator];

    [self _play];
}

- (BITrip *)getTrip {
    return _trip;
}

- (void)_play {
    if (!_play) return;
    if (_entryToPlay != nil) {
        NSLog(@"play: entry: %@", [_entryToPlay debugDescription]);
        [self.delegate tripPlayback:self playEntry:_entryToPlay];
        _entryToPlay = nil;
    }
    BITripEntry *entry = [_entriesEnumerator nextObject];
    if (entry == nil) {
        [self endTrip];
    } else {
        _entryToPlay = entry;
        NSTimeInterval timeInterval = [[entry getTimestamp] timeIntervalSinceDate:_lastDate];
        if (timeInterval <= 0) {
//            NSAssert(timeInterval > 0, @"time interval should be greater than 0, but was: %@", @(timeInterval));
            timeInterval = 0.1;
        }

        [self performSelector:@selector(_play) withObject:nil afterDelay:timeInterval];
        _lastDate = [entry getTimestamp];
        [_timer fire];
    }
}

- (void)endTrip {
    _play = NO;
    [self.delegate tripPlaybackEnded:self];
}

@end