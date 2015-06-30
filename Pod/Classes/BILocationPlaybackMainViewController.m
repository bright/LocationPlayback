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


@implementation BILocationPlaybackMainViewController {
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor redColor];

    UIButton *selectTripToPlayButton = [self createSelectTripToPlayButton];
    [self.view addSubview:selectTripToPlayButton];
    selectTripToPlayButton.frame = CGRectMake(30, 100, selectTripToPlayButton.frame.size.width, selectTripToPlayButton.frame.size.height);
    [selectTripToPlayButton addTarget:self action:@selector(_selectTripToPlay) forControlEvents:UIControlEventTouchUpInside];

    UIButton *recordNewTrip = [self createRecordNewTripButton];
    [self.view addSubview:recordNewTrip];
    recordNewTrip.frame = CGRectMake(30, 300, selectTripToPlayButton.frame.size.width, selectTripToPlayButton.frame.size.height);
    [recordNewTrip addTarget:self action:@selector(_recordNewTrip) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_recordNewTrip {
    BILocationRecordingViewController *recordNewTripVC = [[BILocationRecordingViewController alloc] init];
    recordNewTripVC.delegate = self;
    [self.navigationController pushViewController:recordNewTripVC animated:YES];
}

- (UIButton *)createSelectTripToPlayButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor greenColor];
    button.frame = CGRectMake(0, 0, 150, 70);
    [button setTitle:@"Stored trips" forState:UIControlStateNormal];
    return button;
}

- (UIButton *)createRecordNewTripButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor greenColor];
    button.frame = CGRectMake(0, 0, 150, 70);
    [button setTitle:@"Record new trip" forState:UIControlStateNormal];
    return button;
}

- (void)_selectTripToPlay {
    id <BITripRepository> storage = [[[BILocationPlayback instance] getConfiguration] createStorageWithSeed:@"example_test_seed"];
    NSArray *tripsMetadata = [storage loadAllTripsMetadata];
    BITripsViewController *tripsViewController = [[BITripsViewController alloc] initWithTripMetadata:tripsMetadata];
    tripsViewController.delegate = self;
    [self.navigationController pushViewController:tripsViewController animated:YES];
}

- (void)tripsViewController:(BITripsViewController *)controller onTripSelected:(BITripMetadata *)selectedTripMetadata {
    id <BITripRepository> storage = [self createStorage];
    BITrip *selectedTrip = [storage loadTripWithMetadata: selectedTripMetadata];
    BITripViewController *tripViewController = [[BITripViewController alloc] initWithTrip:selectedTrip];
    tripViewController.delegate = self;
    [self.navigationController pushViewController:tripViewController animated:YES];
}

- (id <BITripRepository>)createStorage {
     return [[[BILocationPlayback instance] getConfiguration] createStorageWithSeed:@"example_test_seed"];
}

- (void)recordingVC:(BILocationRecordingViewController *)sender tripRecorded:(BITrip *)recordedTrip {
    NSError* error;
    [[self createStorage] storeTrip:recordedTrip error:&error];
    if(error != nil){
        NSLog(@"Trip not recorder, trip recording error!: %@", [error description]);
    }
}

- (void)tripViewController:(BITripViewController *)sender playbackRequestedOnTrip:(BITrip *)trip {
    BILocationPlaybackPreviewViewController *previewVC = [[BILocationPlaybackPreviewViewController alloc] initWithTrip:trip];
    previewVC.delegate = self;
    [self.navigationController pushViewController:previewVC animated:YES];
}

- (void)playbackPreviewVC:(BILocationPlaybackPreviewViewController *)controller onPlaybackEndedForTrip:(BITrip *)trip {
    [self.navigationController popViewControllerAnimated:YES];
}


@end