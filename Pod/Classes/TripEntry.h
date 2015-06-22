#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@import CoreLocation;

@interface TripEntry : NSObject

- (instancetype)initWithLocation:(CLLocation *)location;

-(NSDate *) getTimestamp;

@end