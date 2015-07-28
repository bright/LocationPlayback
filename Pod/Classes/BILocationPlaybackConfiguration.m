#import "BILocationPlaybackConfiguration.h"
#import "BITripRepository.h"
#import "BITripLocalRepository.h"
#import "BILocationPlaybackRegistry.h"
#import "BIRegistryWithLocalRepository.h"


@implementation BILocationPlaybackConfiguration {
    id<BILocationPlaybackRegistry> _registry;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _registry = [[BIRegistryWithLocalRepository alloc] init];
        _previewSize = CGSizeMake(200, 200);
    }

    return self;
}

-(void)setRegistry:(id<BILocationPlaybackRegistry>)registry {
    _registry = registry;
}

-(id<BILocationPlaybackRegistry>) getRegistry {
    return _registry;
}

@end