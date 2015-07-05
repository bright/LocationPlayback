#import <Foundation/Foundation.h>

@class BILocationPlaybackConfiguration;


@interface BILocationPlayback : NSObject

+ (BILocationPlayback *)instance;

- (void)show;

- (void)showMiniMapPlayback;

- (BILocationPlaybackConfiguration *)getConfiguration;

@end