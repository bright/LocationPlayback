#import <LocationPlayback/BITrip.h>
#import <LocationPlayback/BITripEntry.h>
#import "BITripSerializer.h"
#import "BITrip.h"


@implementation BITripSerializer {}

- (NSString *)serialize:(BITrip *)trip {
    NSError *writeError = nil;
    NSDictionary *tripAsDict = [trip toDictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tripAsDict options:0 error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(BITrip *) deserialize:(NSString *) serializedTrip {
    NSData *data = [serializedTrip dataUsingEncoding:NSUTF8StringEncoding];
    NSError *readError = nil;
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error: &readError];
    BITrip *trip = [[BITrip alloc] initFromDictionary: jsonObj];
    return trip;
}


@end