#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@import CoreLocation;

@interface BITripEntry : NSObject

- (instancetype)initWithLocation:(CLLocation *)location;

-(NSDate *) getTimestamp;

- (CLLocationCoordinate2D)getCoordinate;

- (CGFloat)speed;

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToEntry:(BITripEntry *)entry;

- (NSUInteger)hash;

- (NSDictionary *)toDictionary;
@end