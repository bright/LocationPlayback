#import "BILocationPlaybackConfiguration.h"
#import "BITripRepository.h"
#import "BITripLocalRepository.h"


@implementation BILocationPlaybackConfiguration {}

- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}

-(id<BITripRepository>) createStorageWithSeed:(NSString *) seed {
    return [[BITripLocalRepository alloc] initWithSeed: seed];
}


@end