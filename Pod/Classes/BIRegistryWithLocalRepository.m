#import "BIRegistryWithLocalRepository.h"
#import "BITripRepository.h"
#import "BITripLocalRepository.h"
#import "BITripRecorder.h"
#import "BISimpleTripRecorder.h"


@implementation BIRegistryWithLocalRepository {}

-(id<BITripRepository>) newRepository {
    return [[BITripLocalRepository alloc] initWithSeed:@"localRepositorySeed"];
}

- (id <BITripRecorder>)newRecorderWithTripName:(NSString *)tripName {
    return [[BISimpleTripRecorder alloc] initWithTripName:tripName];
}

@end