#import <Foundation/Foundation.h>

@import CoreLocation;
@protocol CLLocationManagerDelegate;
@class BITrip;
@protocol BITripRecorderProtocol;
@class BITripEntry;
@protocol BITripRecorder;

@interface BISimpleTripRecorder : NSObject <CLLocationManagerDelegate, BITripRecorder>

@property(nonatomic, weak) id <BITripRecorderProtocol> delegate;

@end