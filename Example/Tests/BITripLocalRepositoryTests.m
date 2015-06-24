@import CoreLocation;

#import <LocationPlayback/BITrip.h>
#import <LocationPlayback/BITripEntry.h>
#import <LocationPlayback/BITripLocalRepository.h>
#import <LocationPlayback/BITripMetadata.h>

SpecBegin(BITripLocalRepositoryTests)

    describe(@"local trips repository tests", ^{
        __block BITrip *trip = nil;
        __block BITrip *trip2 = nil;
        __block BITripLocalRepository *sut = nil;
        beforeEach(^{
            CLLocation *location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(51, 50)
                                                                 altitude:30
                                                       horizontalAccuracy:3
                                                         verticalAccuracy:3
                                                                   course:0
                                                                    speed:30
                                                                timestamp:[NSDate date]];
            BITripEntry *entry = [[BITripEntry alloc] initWithLocation:location];
            trip = [[BITrip alloc] initWithStartDate:[NSDate date] entries:@[entry] name:@"test trip name"];

            CLLocation *location2 = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(54, 53)
                                                                 altitude:30
                                                       horizontalAccuracy:2
                                                         verticalAccuracy:3
                                                                   course:1
                                                                    speed:34
                                                                timestamp:[NSDate date]];

            CLLocation *location3 = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(54, 53)
                                                                  altitude:30
                                                        horizontalAccuracy:2
                                                          verticalAccuracy:3
                                                                    course:1
                                                                     speed:34
                                                                 timestamp:[NSDate date]];

            BITripEntry *entry2_1 = [[BITripEntry alloc] initWithLocation:location2];
            BITripEntry *entry2_2 = [[BITripEntry alloc] initWithLocation:location3];
            trip2 = [[BITrip alloc] initWithStartDate:[NSDate date] entries:@[entry2_1, entry2_2] name:@"test trip 2 name"];

            sut = [[BITripLocalRepository alloc] initWithSeed:[[NSUUID UUID] UUIDString]];
        });

        it(@"stored and loaded 1 trip are equal", ^{
            NSError *error = nil;
            BITripMetadata *tripMetadata = [sut storeTrip:trip error:&error];
            BITrip *loadedTrip = [sut loadTripWithMetadata: tripMetadata];

            expect(error).to.beNil;
            expect([loadedTrip isEqualToTrip: trip]).to.equal(YES);
        });

        it(@"stored and loaded 2 trip are equal", ^{
            NSError *error = nil;
            NSError *error2 = nil;
            BITripMetadata *tripMetadata = [sut storeTrip:trip error:&error];
            BITripMetadata *tripMetadata2 = [sut storeTrip:trip2 error:&error2];

            BITrip *loadedTrip = [sut loadTripWithMetadata: tripMetadata];
            BITrip *loadedTrip2 = [sut loadTripWithMetadata: tripMetadata2];

            expect(error).to.beNil;
            expect(error2).to.beNil;

            expect([loadedTrip isEqualToTrip: trip]).to.equal(YES);
            expect([loadedTrip2 isEqualToTrip: trip2]).to.equal(YES);
        });

        it(@"store trip and check if loadAllTripsMetadata returns metadata for stored trip", ^{
            NSError *error = nil;
            BITripMetadata *tripMetadata = [sut storeTrip:trip error:&error];

            NSArray *allTripsMetadata = [sut loadAllTripsMetadata];

            expect(error).to.beNil;
            expect([allTripsMetadata count]).to.equal(1);
            expect([allTripsMetadata[0] isEqualToMetadata:tripMetadata]).to.equal(YES);
        });

        it(@"store 2 trips and check if loadAllTripsMetadata returns metadata for all stored trips", ^{
            NSError *error = nil;
            NSError *error2 = nil;
            BITripMetadata *tripMetadata = [sut storeTrip:trip error:&error];
            BITripMetadata *tripMetadata2 = [sut storeTrip:trip2 error:&error2];

            NSArray *allTripsMetadata = [sut loadAllTripsMetadata];

            expect(error).to.beNil;
            expect(error2).to.beNil;

            expect([allTripsMetadata count]).to.equal(2);
            expect([allTripsMetadata containsObject:tripMetadata]).to.equal(YES);
            expect([allTripsMetadata containsObject:tripMetadata2]).to.equal(YES);
        });

    });

SpecEnd