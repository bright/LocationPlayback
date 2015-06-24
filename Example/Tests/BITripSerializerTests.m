@import CoreLocation;

#import <LocationPlayback/BITrip.h>
#import <LocationPlayback/BITripEntry.h>
#import <LocationPlayback/BITripSerializer.h>

SpecBegin(BITripSerializerTests)

    describe(@"serialize a trip, deserialize and check if match", ^{
        __block BITrip* trip = nil;
        __block BITrip* deSerializedTrip = nil;

        beforeEach(^{
            BITripSerializer *serializer = [[BITripSerializer alloc] init];
            CLLocation *location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(51, 50)
                                                                 altitude:30
                                                       horizontalAccuracy:3
                                                         verticalAccuracy:3
                                                                   course:0
                                                                    speed:30
                                                                timestamp:[NSDate date]];
            BITripEntry *entry = [[BITripEntry alloc] initWithLocation: location];
            trip = [[BITrip alloc] initWithStartDate:[NSDate date] entries:@[entry] name:@"test trip name"];

            NSString *serializedTrip = [serializer serialize: trip];
            deSerializedTrip = [serializer deserialize:serializedTrip];
        });

        it(@"trip is equal to deserialized trip", ^{
            BOOL areEqual = [deSerializedTrip isEqualToTrip:trip];
            expect(areEqual).to.equal(YES);
        });

    });

SpecEnd