#import <Foundation/Foundation.h>
#import "BITripRepositoryBuilder.h"

@interface BICloudRepositoryBuilder : NSObject<BITripRepositoryBuilder>

- (instancetype)initWithApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey;

@end