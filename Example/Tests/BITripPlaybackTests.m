#import <LocationPlayback/BITripPlayback.h>
#import <LocationPlayback/BITrip.h>
#import <LocationPlayback/BITripEntry.h>
#import <OCMock/OCMock.h>
#import "BIFakePlaybackProtocolImplementation.h"
#import "BIPlaybackPlayedEntry.h"

SpecBegin(BITripPlaybackTests)
    describe(@"TripPlayback play tests", ^{

        CLLocation *(^createLocationWithTimeIntervalSinceStartDate)(NSTimeInterval, NSDate *) = ^(NSTimeInterval timeInterval, NSDate *startDate) {
            NSDate *timestamp = [NSDate dateWithTimeInterval:timeInterval sinceDate:startDate];
            return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(1, 3) altitude:4 horizontalAccuracy:3 verticalAccuracy:2 course:0 speed:30 timestamp:timestamp];
        };

        BITripEntry *(^createTripEntryForLocation)(CLLocation *) = ^(CLLocation *location) {
            return [[BITripEntry alloc] initWithLocation:location timestamp:location.timestamp acceleration:@(1)];
        };

        void(^assertPlayedCorrectly)(BITripPlayback *,BIPlaybackPlayedEntry *, BITripEntry *) = ^(BITripPlayback *playback,BIPlaybackPlayedEntry *playedEntry, BITripEntry *entry){
            NSDate *playbackStartedDate = [playback getPlaybackStartedDate];
            NSDate *tripStartedDate = [[playback getTrip] getStartDate];
            NSTimeInterval diffInRealTrip = [[entry getTimestamp] timeIntervalSinceDate:tripStartedDate];
            NSTimeInterval diffInPlayback = [[playedEntry playedAt] timeIntervalSinceDate:playbackStartedDate];

            NSTimeInterval diff = ABS(diffInPlayback*([playback getSpeedMultiplier]) - diffInRealTrip);
            XCTAssert( diff < [playback getTolerance], @"entry was not played at correct date, diff is:%@ expected:%@", @(diff), @([playback getTolerance]));
        };

        void (^doTestWithTimeIntervals_EndInterval_Tolerance_SpeedMultiplier)(NSArray *, NSTimeInterval, NSTimeInterval, double) = ^(NSArray *timeIntervals, NSTimeInterval tripEndInterval, NSTimeInterval tolerance, double speedMultiplier){
            BIFakePlaybackProtocolImplementation *protocolImplementation = [BIFakePlaybackProtocolImplementation new];
            NSDate *startDate = [NSDate date];
            NSDate *endDate = [NSDate dateWithTimeInterval:tripEndInterval sinceDate:startDate];
            NSMutableArray *entries = [NSMutableArray new];
            for (NSNumber *timeInterval in timeIntervals){
                BITripEntry *entry = createTripEntryForLocation(createLocationWithTimeIntervalSinceStartDate([timeInterval doubleValue], startDate));
                [entries addObject:entry];
            }
            BITrip *trip = [[BITrip alloc] initWithStartDate:startDate
                                                     endDate:endDate
                                                     entries:entries
                                                        name:@"test trip"];
            BITripPlayback *sut = [[BITripPlayback alloc] initWithTrip:trip];
            [sut setSpeedMultiplier: speedMultiplier];
            [sut setTolerance:tolerance];
            sut.delegate = protocolImplementation;
            waitUntilTimeout(tripEndInterval + (1.0/speedMultiplier),^(DoneCallback done) {
                [sut play];
                protocolImplementation.onTripEnded = ^{
                    NSArray *playedEntries = [protocolImplementation playedEntries];
                    XCTAssert([playedEntries count] == [entries count], @"All entries was not played");
                    XCTAssertTrue([protocolImplementation tripWasEnded], @"Trip was not ended");
                    for (NSUInteger i = 0; i <[entries count]; i++){
                        BITripEntry *entry = entries[i];
                        BIPlaybackPlayedEntry* playedPlaybackEntry = playedEntries[i];
                        XCTAssertEqual(entry, [playedPlaybackEntry playedEntry]);
                        assertPlayedCorrectly(sut, playedPlaybackEntry, entry);
                    }
                    done();
                };
            });
        };

        void (^doTestWithTimeIntervals_EndInterval_Tolerance)(NSArray *, NSTimeInterval, NSTimeInterval) = ^(NSArray *timeIntervals, NSTimeInterval tripEndInterval, NSTimeInterval tolerance){
            doTestWithTimeIntervals_EndInterval_Tolerance_SpeedMultiplier(timeIntervals, tripEndInterval, tolerance, 1);
        };

        it(@"test with 5 entries distributed withing 0.05 sec with tolerance 0.1", ^{
            doTestWithTimeIntervals_EndInterval_Tolerance(
                    @[@(0.01), @(0.15), @(0.25), @(0.30), @(0.386)],
                    0.4
                    ,0.1
            );
        });
        
        it(@"test for 100 trip entries distributed in 10 second with tolerance 0.01", ^{
            NSMutableArray *entries = [NSMutableArray new];
            for (NSUInteger i = 0; i < 100; i++){
                [entries addObject:@(i*0.1)];
            }
            doTestWithTimeIntervals_EndInterval_Tolerance(entries, 11, 0.01);
        });

        it(@"test for 100 trip entries distributed in 1 second with tolerance 0.01", ^{
            NSMutableArray *entries = [NSMutableArray new];
            for (NSUInteger i = 0; i < 100; i++){
                [entries addObject:@(i*0.01)];
            }
            doTestWithTimeIntervals_EndInterval_Tolerance(entries, 1.1, 0.01);
        });

        it(@"test for 10 trip entries distributed in 10 second with tolerance 0.05 with speed x10", ^{
            NSMutableArray *entries = [NSMutableArray new];
            for (NSUInteger i = 0; i < 10; i++){
                [entries addObject:@(i*1)];
            }
            doTestWithTimeIntervals_EndInterval_Tolerance_SpeedMultiplier(entries, 1.1, 0.05, 10);
        });

    });

SpecEnd