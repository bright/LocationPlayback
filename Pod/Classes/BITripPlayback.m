#import "BITripPlayback.h"
#import "BITrip.h"
#import "BITripEntry.h"


@implementation BITripPlayback {
    BITrip *_trip;
    NSDate *_tripStartedDate;
    NSArray *_tripEntries;
    NSEnumerator *_entriesEnumerator;
    BITripEntry *_entryToPlay;
    BOOL _play;
    NSTimer *_timer;
    double _tolerance;
    double _speedMultiplier;
    NSDate *_startPlaybackDate;
}

- (instancetype)initWithTrip:(BITrip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;
        _tripStartedDate = [trip getStartDate];
        _tripEntries = [trip getEntries];
        _speedMultiplier = 1.0;
        _tolerance = 0.01;
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
    _startPlaybackDate = [NSDate date];
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

- (void)setTolerance:(NSTimeInterval)tolerance {
    _tolerance = tolerance;
}

- (void)_play {
    if (!_play) return;
    if (_entryToPlay != nil) {
        [self.delegate tripPlayback:self playEntry:_entryToPlay];
        _entryToPlay = nil;
    }
    BITripEntry *entry = [_entriesEnumerator nextObject];
    if (entry == nil) {
        [self endTrip];
    } else {
        _entryToPlay = entry;
        NSTimeInterval timeDiffFromTripStartedToEntryTimestamp = [[entry getTimestamp] timeIntervalSinceDate:_tripStartedDate];
        NSTimeInterval timeInterval = timeDiffFromTripStartedToEntryTimestamp/_speedMultiplier - [[NSDate date] timeIntervalSinceDate:_startPlaybackDate];
        if (timeInterval <= 0) {
            timeInterval = 0.001;
        }
        [_timer invalidate];
        _timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(_play) userInfo:nil repeats:NO];
        [_timer setTolerance:_tolerance];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)endTrip {
    _play = NO;
    [self.delegate tripPlaybackEnded:self];
}

- (void)setSpeedMultiplier:(double)multiplier {
    _speedMultiplier = multiplier;
}

-(double) getSpeedMultiplier {
    return _speedMultiplier;
}

- (NSDate *)getPlaybackStartedDate {
    return _startPlaybackDate;
}

-(NSTimeInterval) getTolerance {
    return _tolerance;
}
@end