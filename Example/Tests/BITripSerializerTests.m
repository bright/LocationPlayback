@import CoreLocation;

#import <LocationPlayback/BITrip.h>
#import <LocationPlayback/BITripEntry.h>
#import <LocationPlayback/BITripSerializer.h>

SpecBegin(BITripSerializerTests)

    describe(@"serialize a trip, deserialize and check if match", ^{
        it(@"can do maths", ^{
            BITripSerializer *serializer = [[BITripSerializer alloc] init];
            CLLocation *location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(50, 50)
                                                                 altitude:30
                                                       horizontalAccuracy:3
                                                         verticalAccuracy:3
                                                                   course:0
                                                                    speed:30
                                                                timestamp:[NSDate date]];
            BITripEntry *entry = [[BITripEntry alloc] initWithLocation: location];
            BITrip *trip = [[BITrip alloc] initWithStartDate:[NSDate date] entries:@[entry] name:@"test trip name"];

            NSString *serializedTrip = [serializer serialize: trip];
            BITrip *deSerializedTrip = [serializer deserialize:serializedTrip];
            expect([deSerializedTrip isEqualToTrip:trip]).to.beTruthy;
        });
    });

SpecEnd