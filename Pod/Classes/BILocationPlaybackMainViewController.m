#import "BILocationPlaybackMainViewController.h"
#import "BITripsViewController.h"


@implementation BILocationPlaybackMainViewController {
    UIButton *_selectTripToPlay;
}

- (void)loadView {
    [super loadView];
    _selectTripToPlay = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    _selectTripToPlay.titleLabel.text = @"Select trip to play";
    [_selectTripToPlay addTarget:self action:@selector(_selectTripToPlay) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_selectTripToPlay {
    BITripsViewController* tripsViewController = [[BITripsViewController alloc] initWithTripMetadata:@[]];
    tripsViewController.delegate = self;
    [self.navigationController pushViewController:tripsViewController animated:YES];
}


@end