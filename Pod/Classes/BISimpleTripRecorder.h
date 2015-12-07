#import <Foundation/Foundation.h>
#import <BITripRecorder.h>

@import CoreLocation;
@protocol CLLocationManagerDelegate;
@class BITrip;
@protocol BITripRecorderProtocol;
@class BITripEntry;

@interface BISimpleTripRecorder : NSObject <CLLocationManagerDelegate, BITripRecorder>

@property(nonatomic, weak) id <BITripRecorderProtocol> delegate;

@end