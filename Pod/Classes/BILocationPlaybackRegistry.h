#import <Foundation/Foundation.h>

@protocol BITripRepository;
@protocol BITripRecorder;

@protocol BILocationPlaybackRegistry <NSObject>

- (id <BITripRepository>)newRepository;

- (id <BITripRecorder>)newRecorderWithTripName:(NSString *)tripName;

@end