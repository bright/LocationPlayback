#import <Foundation/Foundation.h>
#import "BITripRepository.h"


@interface BITripLocalRepository : NSObject<BITripRepository>

- (instancetype)initWithSeed:(NSString *)seed;

@end