#import <Foundation/Foundation.h>

@class BILocationPlaybackConfiguration;


@interface BILocationPlayback : NSObject

+ (BILocationPlayback *)instance;

- (void)show;

- (BILocationPlaybackConfiguration *)getConfiguration;

@end