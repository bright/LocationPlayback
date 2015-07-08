#import "BICloudRepositoryBuilder.h"
#import "PFAnalytics.h"
#import "Parse.h"
#import "BIParseTripRepository.h"


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
    return [[BIParseTripRepository alloc] init];
}


@end