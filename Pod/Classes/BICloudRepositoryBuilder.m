#import "BICloudRepositoryBuilder.h"
#import "PFAnalytics.h"
#import "Parse.h"
#import "BICloudTripRepository.h"


@implementation BICloudRepositoryBuilder {}

- (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions
                        applicationId:(NSString *)applicationId
                            clientKey:(NSString *)clientKey {
    self = [super init];
    if (self) {
        [Parse enableLocalDatastore];
        [Parse setApplicationId:applicationId
                      clientKey:clientKey];
        [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    }
    return self;
}

- (id <BITripRepository>)newRepository {
    return [[BICloudTripRepository alloc] init];
}


@end