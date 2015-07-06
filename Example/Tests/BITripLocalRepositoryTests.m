@import CoreLocation;

#import <LocationPlayback/BITrip.h>
#import <LocationPlayback/BITripEntry.h>
#import <LocationPlayback/BITripLocalRepository.h>
#import <LocationPlayback/BITripMetadata.h>
#import <Specta/SpectaDSL.h>
#import <Specta/SPTSpec.h>
#import <Expecta/Expecta.h>

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
            NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:3600];
            trip = [[BITrip alloc] initWithStartDate:[NSDate date] endDate:endDate entries:@[entry] name:@"test trip name"];

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
            NSDate *endDate2 = [NSDate dateWithTimeIntervalSinceNow:36000];
            trip2 = [[BITrip alloc] initWithStartDate:[NSDate date] endDate:endDate2 entries:@[entry2_1, entry2_2] name:@"test trip 2 name"];

            sut = [[BITripLocalRepository alloc] initWithSeed:[[NSUUID UUID] UUIDString]];
        });

        it(@"stored and loaded 1 trip are equal", ^{
            __block BITripMetadata *tripMetadata = nil;
            waitUntil(^(DoneCallback done) {
                [sut storeTrip:trip responseBlock:^(BITripMetadata *metadata, NSError *error) {
                    expect(error).to.beNil;
                    tripMetadata = metadata;
                    done();
                }];
            });
            waitUntil(^(DoneCallback done) {
                [sut loadTripWithMetadata:tripMetadata responseBlock:^(BITrip *loadedTrip, NSError *error) {
                    expect(error).to.beNil;
                    expect([loadedTrip isEqualToTrip:trip]).to.equal(YES);
                    done();
                }];
            });
        });

        it(@"stored and loaded 2 trip are equal", ^{
            __block BITripMetadata *tripMetadata = nil;
            waitUntil(^(DoneCallback done) {
                [sut storeTrip:trip responseBlock:^(BITripMetadata *metadata, NSError *error) {
                    expect(error).to.beNil;
                    tripMetadata = metadata;
                    done();
                }];
            });
            __block BITripMetadata *tripMetadata2 = nil;
            waitUntil(^(DoneCallback done) {
                [sut storeTrip:trip2 responseBlock:^(BITripMetadata *metadata, NSError *error) {
                    expect(error).to.beNil;
                    tripMetadata2 = metadata;
                    done();
                }];
            });
            __block BITrip *loadedTrip = nil;
            waitUntil(^(DoneCallback done) {
                [sut loadTripWithMetadata:tripMetadata responseBlock:^(BITrip *trip, NSError *error) {
                    expect(error).to.beNil;
                    loadedTrip = trip;
                    done();
                }];
            });


            __block BITrip *loadedTrip2 = nil;
            waitUntil(^(DoneCallback done) {
                [sut loadTripWithMetadata:tripMetadata2 responseBlock:^(BITrip *trip, NSError *error) {
                    expect(error).to.beNil;
                    loadedTrip2 = trip;
                    done();
                }];
            });

            expect([loadedTrip isEqualToTrip:trip]).to.equal(YES);
            expect([loadedTrip2 isEqualToTrip:trip2]).to.equal(YES);
        });

        it(@"store trip and check if loadAllTripsMetadata returns metadata for stored trip", ^{
            NSError *error = nil;
            __block BITripMetadata *tripMetadata = nil;
            waitUntil(^(DoneCallback done) {
                [sut storeTrip:trip responseBlock:^(BITripMetadata *metadata, NSError *error) {
                    expect(error).to.beNil;
                    tripMetadata = metadata;
                    done();
                }];
            });
            waitUntil(^(DoneCallback done) {
                [sut loadAllTripsMetadata:^(NSArray *allTripsMetadata, NSError *error) {
                    expect(error).to.beNil;
                    expect([allTripsMetadata count]).to.equal(1);
                    expect([allTripsMetadata[0] isEqualToMetadata:tripMetadata]).to.equal(YES);
                    done();
                }];
            });
        });

        it(@"store 2 trips and check if loadAllTripsMetadata returns metadata for all stored trips", ^{
            NSError *error = nil;
            NSError *error2 = nil;
            __block BITripMetadata *tripMetadata = nil;
            __block BITripMetadata *tripMetadata2 = nil;
            waitUntil(^(DoneCallback done) {
                [sut storeTrip:trip responseBlock:^(BITripMetadata *metadata, NSError *error) {
                    expect(error).to.beNil;
                    tripMetadata = metadata;
                    done();
                }];
            });
            waitUntil(^(DoneCallback done) {
                [sut storeTrip:trip2 responseBlock:^(BITripMetadata *metadata, NSError *error) {
                    expect(error).to.beNil;
                    tripMetadata2 = metadata;
                    done();
                }];
            });
            waitUntil(^(DoneCallback done) {
                [sut loadAllTripsMetadata:^(NSArray *allTripsMetadata, NSError *error) {
                    expect(error).to.beNil;
                    expect([allTripsMetadata count]).to.equal(2);
                    expect([allTripsMetadata containsObject:tripMetadata]).to.equal(YES);
                    expect([allTripsMetadata containsObject:tripMetadata2]).to.equal(YES);
                    done();
                }];
            });
        });

    });

SpecEnd