#import <Foundation/Foundation.h>

@protocol BITripRepository;

@protocol BITripRepositoryBuilder <NSObject>
-(id<BITripRepository>) newRepository;
@end