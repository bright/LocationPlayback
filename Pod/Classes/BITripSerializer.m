#import <LocationPlayback/BITrip.h>
#import <LocationPlayback/BITripEntry.h>
#import "BITripSerializer.h"
#import "BITrip.h"


@implementation BITripSerializer {}

- (NSString *)serialize:(BITrip *)trip {
    return nil;
}

-(BITrip *) deserialize:(NSString *) serializedTrip {
    return [[BITrip alloc] initWithStartDate:[NSDate date] entries:@[] name:@"some name"];
}


@end