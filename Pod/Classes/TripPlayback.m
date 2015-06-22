#import "TripPlayback.h"
#import "Trip.h"
#import "TripEntry.h"


@implementation TripPlayback {
    Trip *_trip;
    NSTimer *_timer;
    NSDate *_lastDate;
    NSDate *_startDate;
    NSArray *_tripEntries;
    NSEnumerator *_entriesEnumerator;
    TripEntry *_entryToPlay;
}

- (instancetype)initWithTrip:(Trip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;
        _startDate = [trip getStartDate];
        _lastDate = _startDate;
        _tripEntries = [trip getEntries];
    }
    return self;
}

+ (instancetype)playbackWithTrip:(Trip *)trip {
    return [[self alloc] initWithTrip:trip];
}


-(void) play {
    
    if([_tripEntries count] == 0) return;
    _entriesEnumerator = [_tripEntries objectEnumerator];
    
    [self _play];
}

- (void)_play {
    if(_entryToPlay != nil){
        NSLog(@"play: entry: %@", [_entryToPlay debugDescription]);
        _entryToPlay = nil;
    }
    TripEntry* entry = [_entriesEnumerator nextObject];
    if(entry == nil){
        NSLog(@"trip recording ended!");
    } else {
        _entryToPlay = entry;
        NSTimeInterval timeInterval = [[entry getTimestamp] timeIntervalSinceDate:_lastDate];
        NSAssert(timeInterval > 0, @"time interval should be greater than 0");
        [self performSelector:@selector(_play) withObject:nil afterDelay:timeInterval];
        _lastDate = [entry getTimestamp];
        [_timer fire];
    }
}

@end