#import "BIRegistryWithCloudRepository.h"
#import "PFAnalytics.h"
#import "Parse.h"
#import "BIParseTripRepository.h"
#import "BITripRecorder.h"
#import "BISimpleTripRecorder.h"


@implementation BIRegistryWithCloudRepository {}

- (instancetype)initWithApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey {
    self = [super init];
    if (self) {
        [Parse enableLocalDatastore];
        [Parse setApplicationId:applicationId
                      clientKey:clientKey];
    }
    return self;
}

- (id <BITripRepository>)newRepository {
    return [[BIParseTripRepository alloc] init];
}

- (id <BITripRecorder>)newRecorderWithTripName:(NSString *)tripName {
    return [[BISimpleTripRecorder alloc] initWithTripName:tripName];
}

@end