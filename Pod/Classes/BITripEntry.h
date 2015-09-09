#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@import CoreLocation;

@interface BITripEntry : NSObject

- (instancetype)initWithLocation:(CLLocation *)location;

- (instancetype)initWithLocation:(CLLocation *)location timestamp:(NSDate *)timestamp acceleration:(NSNumber *)acceleration;

- (instancetype)initWithLocation:(CLLocation *)location acceleration:(NSNumber *)acceleration;

-(NSDate *) getTimestamp;

- (CLLocationCoordinate2D)getCoordinate;

/**
* Returns the speed of the location in m/s
*/
- (CGFloat)speed;

/**
* Returns acceleration in m/sec2, returns CGFLOAT_MIN if acceleration not defined
*/
-(NSNumber *)acceleration;

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToEntry:(BITripEntry *)entry;

- (NSUInteger)hash;

- (NSDictionary *)toDictionary;
@end