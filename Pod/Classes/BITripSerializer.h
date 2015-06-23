#import <Foundation/Foundation.h>

@class BITrip;


@interface BITripSerializer : NSObject

-(NSString *) serialize:(BITrip *) trip;

- (BITrip *)deserialize:(NSString *)serializedTrip;
@end