#import <Foundation/Foundation.h>

@class BITrip;
@class BITripMetadata;

@protocol BITripRepository <NSObject>

- (BITripMetadata *)storeTrip:(BITrip *)tripToStore error:(NSError **)error;

- (BITrip *)loadTripWithMetadata:(BITripMetadata *)tripMetadata;

/**
* @return objects of type `BITripMetadata`
*/
- (NSArray *)loadAllTripsMetadata;

@end