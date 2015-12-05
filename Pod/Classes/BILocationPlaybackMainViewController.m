#import "BILocationPlaybackMainViewController.h"
#import "BILocationPlaybackMainViewControllerProtocol.h"
#import "BITripPlayback.h"
#import "BILocationPlayback.h"
#import "BILocationPlaybackConfiguration.h"
#import "BITripRepository.h"
#import "BITripMetadata.h"
#import "BITrip.h"
#import "BIStyles.h"
#import "ALView+PureLayout.h"

#define LEFT_RIGHT_INSET 20
#define BUTTON_HEIGHT 100
#define VERTICAL_SPACING 20

@implementation BILocationPlaybackMainViewController {
    BOOL _shouldPopPreviewControllerOnTripStop;
    id <BITripRepository> _storage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _shouldPopPreviewControllerOnTripStop = NO;
    if ([[BILocationPlayback instance] isTripPlaybackPlaying]) {
        BITrip *trip = [[BILocationPlayback instance] getPlayedTrip];
        BILocationPlaybackPreviewViewController *previewVC = [[BILocationPlaybackPreviewViewController alloc] initWithTrip:trip];
        previewVC.delegate = self;
        [self.navigationController pushViewController:previewVC animated:NO];
        _shouldPopPreviewControllerOnTripStop = YES;
    }
}

- (void)loadView {
    [super loadView];
    _storage = [self createStorage];
    self.title = @"Location Playback";
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *selectTripToPlayButton = [BIStyles createButtonWithName:@"Stored trips"];
    [self.view addSubview:selectTripToPlayButton];
    [selectTripToPlayButton addTarget:self action:@selector(_selectTripToPlay) forControlEvents:UIControlEventTouchUpInside];

    UIButton *recordNewTrip = [BIStyles createButtonWithName:@"Record new trip"];
    [self.view addSubview:recordNewTrip];
    [recordNewTrip addTarget:self action:@selector(_recordNewTrip) forControlEvents:UIControlEventTouchUpInside];

    [selectTripToPlayButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [selectTripToPlayButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [selectTripToPlayButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [selectTripToPlayButton autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];

    [recordNewTrip autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:selectTripToPlayButton withOffset:VERTICAL_SPACING];
    [recordNewTrip autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [recordNewTrip autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [recordNewTrip autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];

}

- (void)_recordNewTrip {
    BILocationRecordingViewController *recordNewTripVC = [[BILocationRecordingViewController alloc] init];
    recordNewTripVC.delegate = self;
    [self.navigationController pushViewController:recordNewTripVC animated:YES];
}

- (void)_selectTripToPlay {
    id <BITripRepository> storage = [[[BILocationPlayback instance] getConfiguration] createStorage];
    __weak BILocationPlaybackMainViewController *weakSelf = self;
    [storage loadAllTripsMetadata:^(NSArray *tripsMetadata, NSError *error) {
        BILocationPlaybackMainViewController *strongSelf = weakSelf;
        if (error == nil) {
            BOOL allowDelete = [storage respondsToSelector:@selector(deleteTripForMetadata:responseBlock:)];
            [strongSelf showTripsViewController:tripsMetadata allowDelete:allowDelete];
        }
    }];
}

- (void)showTripsViewController:(NSArray *)tripsMetadata allowDelete:(BOOL)allowDelete {
    BITripsViewController *tripsViewController = [[BITripsViewController alloc] initWithTripsMetadata:tripsMetadata];
    tripsViewController.delegate = self;
    if(allowDelete){
        [tripsViewController enableDelete];
    }
    [self.navigationController pushViewController:tripsViewController animated:YES];
}

- (void)tripsViewController:(BITripsViewController *)controller onTripSelected:(BITripMetadata *)selectedTripMetadata {
    __weak BILocationPlaybackMainViewController *weakSelf = self;
    [_storage loadTripWithMetadata:selectedTripMetadata responseBlock:^(BITrip *trip, NSError *error) {
        BILocationPlaybackMainViewController *strongSelf = weakSelf;
        if (trip && error == nil) {
            [strongSelf showTripViewControllerForTrip:trip];
        } else {
            NSLog(@"something went wrong");
        }
    }];
}

- (void)showTripViewControllerForTrip:(BITrip *)trip {
    BITripViewController *tripViewController = [[BITripViewController alloc] initWithTrip:trip];
    tripViewController.delegate = self;
    [self.navigationController pushViewController:tripViewController animated:YES];
}

- (id <BITripRepository>)createStorage {
    return [[[BILocationPlayback instance] getConfiguration] createStorage];
}

- (void)tripsViewController:(BITripsViewController *)controller onTripDeleted:(BITripMetadata *)metadata {
    [_storage deleteTripForMetadata:metadata responseBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"trip deleted success?: %@", @(succeeded));
        if(error){
            NSLog(@"error occured while deleting trip: %@", error);
        }
    }];
}

- (void)recordingVC:(BILocationRecordingViewController *)sender tripRecorded:(BITrip *)recordedTrip {
    [_storage storeTrip:recordedTrip responseBlock:^(BITripMetadata *metadata, NSError *error) {
        if (error != nil) {
            NSLog(@"Trip not recorder, trip recording error!: %@", [error description]);
        }
    }];
}

- (void)tripViewController:(BITripViewController *)sender openPlaybackViewRequestedOnTrip:(BITrip *)trip {
    BILocationPlaybackPreviewViewController *previewVC = [[BILocationPlaybackPreviewViewController alloc] initWithTrip:trip];
    previewVC.delegate = self;
    [self.navigationController pushViewController:previewVC animated:YES];
}

- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller tripPlaybackStartRequested:(BITrip *)trip {
    [self.delegate userRequestedTripPlaybackOnTrip:trip];
}

- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller tripPlaybackStopRequested:(BITrip *)trip {
    [self.delegate userRequestedStopPlaybackOnTrip:trip];
    if (_shouldPopPreviewControllerOnTripStop) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end