#import <Foundation/Foundation.h>

@protocol BITripRepository;


@interface BILocationPlaybackConfiguration : NSObject
- (id <BITripRepository>)createStorageWithSeed:(NSString *)seed;
@end