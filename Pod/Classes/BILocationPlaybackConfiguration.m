#import "BILocationPlaybackConfiguration.h"
#import "BITripRepository.h"
#import "BITripLocalRepository.h"
#import "BITripRepositoryBuilder.h"
#import "BILocalRepositoryBuilder.h"


@implementation BILocationPlaybackConfiguration {
    id<BITripRepositoryBuilder> _repositoryBuilder;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _repositoryBuilder = [[BILocalRepositoryBuilder alloc] init];
    }

    return self;
}

-(void) setTripRepositoriesBuilder:(id<BITripRepositoryBuilder>) repositoryBuilder {
    _repositoryBuilder = repositoryBuilder;
}

- (id <BITripRepository>)createStorage {
    return [_repositoryBuilder newRepository];
}


@end