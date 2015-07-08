#import "BICloudRepositoryBuilder.h"
#import "PFAnalytics.h"
#import "Parse.h"
#import "BICloudTripRepository.h"


@implementation BICloudRepositoryBuilder {}

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
    return [[BICloudTripRepository alloc] init];
}


@end