#import <Foundation/Foundation.h>
#import "BILocationPlaybackRegistry.h"

@interface BIRegistryWithCloudRepository : NSObject<BILocationPlaybackRegistry>

- (instancetype)initWithApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey;

@end