#import <CFNetwork/CFNetwork.h>
#import "BILocationPlaybackMainViewController.h"
#import "BITripsViewController.h"
#import "BILocationPlayback.h"
#import "BILocationPlaybackConfiguration.h"
#import "BITripRepository.h"
#import "BITripMetadata.h"
#import "BITripPlayback.h"
#import "BILocationPlaybackPreviewViewController.h"
#import "BILocationRecordingViewController.h"
#import "BITrip.h"
#import "BITripViewController.h"
#import "BIStyles.h"
#import "ALView+PureLayout.h"

#define LEFT_RIGHT_INSET 20
#define BUTTON_HEIGHT 100
#define VERTICAL_SPACING 20

@implementation BILocationPlaybackMainViewController {}

- (void)loadView {
    [super loadView];
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
        if(error == nil){
            [strongSelf showTripsViewController: tripsMetadata];
        }
    }];
}

- (void)showTripsViewController:(NSArray *)tripsMetadata {
    BITripsViewController *tripsViewController = [[BITripsViewController alloc] initWithTripMetadata:tripsMetadata];
    tripsViewController.delegate = self;
    [self.navigationController pushViewController:tripsViewController animated:YES];
}

- (void)tripsViewController:(BITripsViewController *)controller onTripSelected:(BITripMetadata *)selectedTripMetadata {
    id <BITripRepository> storage = [self createStorage];
    __weak BILocationPlaybackMainViewController *weakSelf = self;
    [storage loadTripWithMetadata: selectedTripMetadata responseBlock:^(BITrip* trip, NSError * error){
        BILocationPlaybackMainViewController *strongSelf = weakSelf;
        if(trip && error == nil){
            [strongSelf showTripViewControllerForTrip: trip];
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

- (void)recordingVC:(BILocationRecordingViewController *)sender tripRecorded:(BITrip *)recordedTrip {
    [[self createStorage] storeTrip:recordedTrip responseBlock:^(BITripMetadata *metadata, NSError *error) {
        if(error != nil){
            NSLog(@"Trip not recorder, trip recording error!: %@", [error description]);
        }
    }];
}

- (void)tripViewController:(BITripViewController *)sender openPlaybackViewRequestedOnTrip:(BITrip *)trip {
    BILocationPlaybackPreviewViewController *previewVC = [[BILocationPlaybackPreviewViewController alloc] initWithTrip:trip];
    previewVC.delegate = self;
    [self.navigationController pushViewController:previewVC animated:YES];
}

- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller tripPlaybackStartRequested:(BITrip *)trip{
    [self.delegate userRequestedTripPlaybackOnTrip: trip];
}

- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller tripPlaybackStopRequested:(BITrip *)trip {
    [self.delegate userRequestedStopPlaybackOnTrip: trip];
}


@end