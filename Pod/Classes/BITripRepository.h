#import <Foundation/Foundation.h>

@class BITrip;
@class BITripMetadata;

@protocol BITripRepository <NSObject>

- (void)storeTrip:(BITrip *)tripToStore responseBlock:(void (^)(BITripMetadata *, NSError *))block;

- (void)loadTripWithMetadata:(BITripMetadata *)tripMetadata responseBlock:(void (^)(BITrip *, NSError *))block;

/**
* @return objects of type `BITripMetadata`
*/
- (void)loadAllTripsMetadata:(void (^)(NSArray*, NSError *))responseBlock;

@end