#import <Foundation/Foundation.h>

@import CoreLocation;
@protocol CLLocationManagerDelegate;
@class BITrip;
@protocol BITripRecorderProtocol;
@class BITripEntry;

@interface BITripRecorder : NSObject <CLLocationManagerDelegate>

@property(nonatomic, weak) id <BITripRecorderProtocol> delegate;

- (instancetype)initWithTripName:(NSString *)tripName;

- (void)start;

- (BITrip *)stop;

@end

@protocol BITripRecorderProtocol <NSObject>
@optional
- (void)tripRecorder:(BITripRecorder *)recorder didRecordTripEntry:(BITripEntry *)entry;

- (void)tripRecorderDidStartRecording:(BITripRecorder *)recorder;

- (void)tripRecorder:(BITripRecorder *)recorder didStopRecordingTrip:(BITrip *)recorderTrip;
@end