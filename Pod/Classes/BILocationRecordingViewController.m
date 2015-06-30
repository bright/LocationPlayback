#import "BILocationRecordingViewController.h"
#import "BITripRecordingPreview.h"
#import "BITrip.h"
#import "BITripRecorder.h"
#import "BITripSummaryView.h"
#import "ALView+PureLayout.h"


@implementation BILocationRecordingViewController {

    UIButton *_startRecordingButton;
    UIButton *_stopRecordingButton;
    UIButton *_saveTripButton;
    UIButton *_discardTripButton;
    BITripRecorder *_tripRecorder;
    BITripRecordingPreview *_recordingPreview;
    BITrip *_trip;
//    BITripSummaryView *_summary;
    UITextField *_rideNameTextField;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor redColor];

    _startRecordingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_startRecordingButton setTitle:@"Start new ride" forState:UIControlStateNormal];
    _startRecordingButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_startRecordingButton];
    [_startRecordingButton addTarget:self action:@selector(_startRecording) forControlEvents:UIControlEventTouchUpInside];

    _stopRecordingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stopRecordingButton.backgroundColor = [UIColor greenColor];
    [_stopRecordingButton setTitle:@"Stop ride" forState:UIControlStateNormal];
    [self.view addSubview:_stopRecordingButton];
    [_stopRecordingButton addTarget:self action:@selector(_stopRecording) forControlEvents:UIControlEventTouchUpInside];
    _stopRecordingButton.hidden = YES;

    _rideNameTextField = [UITextField new];
    _rideNameTextField.textAlignment = NSTextAlignmentCenter;
    _rideNameTextField.delegate = self;
    _rideNameTextField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_rideNameTextField];


    _saveTripButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_saveTripButton setTitle:@"Save Trip" forState:UIControlStateNormal];
    _saveTripButton.backgroundColor = [UIColor greenColor];
    _saveTripButton.tintColor = [UIColor brownColor];
    [_saveTripButton addTarget:self action:@selector(saveTrip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveTripButton];
    _saveTripButton.hidden = YES;

    _discardTripButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_discardTripButton setTitle:@"Discard Trip" forState:UIControlStateNormal];
    _discardTripButton.backgroundColor = [UIColor greenColor];
    [_discardTripButton addTarget:self action:@selector(discardTrip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_discardTripButton];
    _discardTripButton.hidden = YES;

    [_rideNameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [_rideNameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_rideNameTextField autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_rideNameTextField autoSetDimension:ALDimensionHeight toSize:50];

    [_startRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_startRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_startRecordingButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField];
    [_startRecordingButton autoSetDimension:ALDimensionHeight toSize:75];

    [_stopRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_stopRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_stopRecordingButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField];
    [_stopRecordingButton autoSetDimension:ALDimensionHeight toSize:75];

    [_saveTripButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField];
    [_saveTripButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_saveTripButton autoSetDimension:ALDimensionHeight toSize:40];
    [_saveTripButton autoSetDimension:ALDimensionWidth toSize:100];

    [_discardTripButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField];
    [_discardTripButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_discardTripButton autoSetDimension:ALDimensionHeight toSize:40];
    [_discardTripButton autoSetDimension:ALDimensionWidth toSize:100];

}

- (void)discardTrip {
    _startRecordingButton.hidden = NO;
    _saveTripButton.hidden = YES;
    _discardTripButton.hidden = YES;
}

- (void)saveTrip {
    _startRecordingButton.hidden = NO;
    _saveTripButton.hidden = YES;
    _discardTripButton.hidden = YES;
}

- (void)_stopRecording {
    _trip = [_tripRecorder stop];
    _stopRecordingButton.hidden = YES;
    [self.delegate recordingVC: self tripRecorded: _trip];
    _saveTripButton.hidden = NO;
    _discardTripButton.hidden = NO;
//    _summary = [[BIRecordedTripSummaryView alloc] initWithFrame:self.view.bounds trip: _trip];
//    _summary.delegate = self;
//    [self.view addSubview: _summary];
}

- (void)_startRecording {
    [_recordingPreview removeFromSuperview];

    _tripRecorder = [[BITripRecorder alloc] init];
    [self showRecordingPreviewForRecorder: _tripRecorder];
    [_tripRecorder start];
    _stopRecordingButton.hidden = NO;
    _startRecordingButton.hidden = YES;
}

- (void)showRecordingPreviewForRecorder:(BITripRecorder *) tripRecorder {
    _recordingPreview = [[BITripRecordingPreview alloc] initWithTripRecorder:tripRecorder];
    [self.view addSubview:_recordingPreview];
    [_recordingPreview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_stopRecordingButton withOffset:100];
    [_recordingPreview autoAlignAxis:ALAxisVertical toSameAxisOfView:_stopRecordingButton];
    [_recordingPreview autoSetDimension:ALDimensionHeight toSize:50];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


@end