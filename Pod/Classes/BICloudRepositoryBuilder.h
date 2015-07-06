#import <Foundation/Foundation.h>
#import "BITripRepositoryBuilder.h"

@interface BICloudRepositoryBuilder : NSObject<BITripRepositoryBuilder>

- (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions applicationId:(NSString *)applicationId clientKey:(NSString *)clientKey;

@end