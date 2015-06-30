#import "BILocalRepositoryBuilder.h"
#import "BITripRepository.h"
#import "BITripLocalRepository.h"


@implementation BILocalRepositoryBuilder {}

-(id<BITripRepository>) newRepository {
    return [[BITripLocalRepository alloc] initWithSeed:@"localRepositorySeed"];
}

@end