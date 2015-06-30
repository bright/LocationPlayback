#import "BICloudRepositoryBuilder.h"
#import "PFAnalytics.h"
#import "Parse.h"
#import "BICloudTripRepository.h"


@implementation BICloudRepositoryBuilder {}

- (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions {
    self = [super init];
    if (self) {
        [Parse enableLocalDatastore];
        [Parse setApplicationId:@"zwWNbqiQCuKo3hIKfnHPzIJfWgs2OjmyQSWijHlf"
                      clientKey:@"yp7XjY1WvJnPRJNcg9ukAGODnqZUCeshLVCJvSQs"];
        [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    }
    return self;
}

- (id <BITripRepository>)newRepository {
    return [[BICloudTripRepository alloc] init];
}


@end