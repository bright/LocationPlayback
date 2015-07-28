#import <Foundation/Foundation.h>

@class BITrip;
@protocol BITripRecorderProtocol;
@class BITripEntry;

@protocol BITripRecorder <NSObject>

@property(nonatomic, weak) id <BITripRecorderProtocol> delegate;

- (instancetype)initWithTripName:(NSString *)tripName;

- (void)start;

- (BITrip *)stop;

@end

@protocol BITripRecorderProtocol <NSObject>

@optional

- (void)tripRecorder:(id<BITripRecorder>)recorder didRecordTripEntry:(BITripEntry *)entry;

- (void)tripRecorderDidStartRecording:(id<BITripRecorder>)recorder;

- (void)tripRecorder:(id<BITripRecorder>)recorder didStopRecordingTrip:(BITrip *)recorderTrip;

@end