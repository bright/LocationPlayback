#import <Foundation/Foundation.h>

@class BILocationPlaybackConfiguration;
@class BITrip;
@class BITripEntry;
@protocol BILocationPlaybackMainViewControllerProtocol;
@protocol BITripPlaybackProtocol;

@interface BILocationPlayback : NSObject <BILocationPlaybackMainViewControllerProtocol, BITripPlaybackProtocol>

- (NSString *)tripStartedNotification;

- (NSString *)tripEndedNotification;

- (NSString *)tripUpdateNotification;

-(BOOL) isTripPlaybackPlaying;

- (BITrip *)getPlayedTrip;

+ (BILocationPlayback *)instance;

- (void)show;

- (void)showMiniMapPlayback;

- (BILocationPlaybackConfiguration *)getConfiguration;

- (BITrip *)getTripFromUserInfo:(NSDictionary *)userInfo;

- (BITripEntry *)getTripEntryFromUserInfo:(NSDictionary *)userInfo;
@end