#import "BILocationRecordingViewController.h"
#import "BITripRecordingPreview.h"
#import "BITrip.h"
#import "ALView+PureLayout.h"
#import "BIStyles.h"

#define LEFT_RIGHT_INSET 20
#define BUTTON_HEIGHT 75
#define SMALL_BUTTON_WIDTH 100
#define VERTICAL_SPACING 10

@implementation BILocationRecordingViewController {

    UIButton *_startRecordingButton;
    UIButton *_stopRecordingButton;
    UIButton *_saveTripButton;
    UIButton *_discardTripButton;
    BITripRecorder *_tripRecorder;
    BITripRecordingPreview *_recordingPreview;
    BITrip *_trip;
    UITextField *_rideNameTextField;
}

- (void)loadView {
    [super loadView];
    self.title = @"Trip Recording";
    self.view.backgroundColor = [UIColor whiteColor];

    _startRecordingButton = [BIStyles createButtonWithName:@"Start new ride"];
    [self.view addSubview:_startRecordingButton];
    [_startRecordingButton addTarget:self action:@selector(_startRecording) forControlEvents:UIControlEventTouchUpInside];

    _stopRecordingButton = [BIStyles createButtonWithName:@"Stop ride"];
    [self.view addSubview:_stopRecordingButton];
    [_stopRecordingButton addTarget:self action:@selector(_stopRecording) forControlEvents:UIControlEventTouchUpInside];
    _stopRecordingButton.hidden = YES;

    _rideNameTextField = [BIStyles createTextField];
    _rideNameTextField.delegate = self;
    _rideNameTextField.placeholder = @"Trip name";
    [self.view addSubview:_rideNameTextField];


    _saveTripButton = [BIStyles createButtonWithName:@"Save trip"];
    [_saveTripButton addTarget:self action:@selector(saveTrip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveTripButton];
    _saveTripButton.hidden = YES;

    _discardTripButton = [BIStyles createButtonWithName:@"Discard Trip"];
    [_discardTripButton addTarget:self action:@selector(discardTrip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_discardTripButton];
    _discardTripButton.hidden = YES;

    [_rideNameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [_rideNameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [_rideNameTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [_rideNameTextField autoSetDimension:ALDimensionHeight toSize:50];

    [_startRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [_startRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [_startRecordingButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField withOffset:VERTICAL_SPACING];
    [_startRecordingButton autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];

    [_stopRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [_stopRecordingButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [_stopRecordingButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField withOffset:VERTICAL_SPACING];
    [_stopRecordingButton autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];

    [_saveTripButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField withOffset:VERTICAL_SPACING];
    [_saveTripButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
    [_saveTripButton autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];
    [_saveTripButton autoSetDimension:ALDimensionWidth toSize:SMALL_BUTTON_WIDTH];

    [_discardTripButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rideNameTextField withOffset:VERTICAL_SPACING];
    [_discardTripButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    [_discardTripButton autoSetDimension:ALDimensionHeight toSize:BUTTON_HEIGHT];
    [_discardTripButton autoSetDimension:ALDimensionWidth toSize:SMALL_BUTTON_WIDTH];

}

- (void)_stopRecording {
    _trip = [_tripRecorder stop];
    _stopRecordingButton.hidden = YES;
    _saveTripButton.hidden = NO;
    _discardTripButton.hidden = NO;
}

- (void)_startRecording {
    [_recordingPreview removeFromSuperview];

    _tripRecorder = [[BITripRecorder alloc] initWithTripName:_rideNameTextField.text];
    [self showRecordingPreviewForRecorder: _tripRecorder];
    [_tripRecorder start];
    _stopRecordingButton.hidden = NO;
    _startRecordingButton.hidden = YES;
    _rideNameTextField.enabled = NO;

}

- (void)discardTrip {
    _startRecordingButton.hidden = NO;
    _saveTripButton.hidden = YES;
    _discardTripButton.hidden = YES;
    _recordingPreview.hidden = YES;
    _rideNameTextField.enabled = YES;
}

- (void)saveTrip {
    [self.delegate recordingVC: self tripRecorded: _trip];
    _startRecordingButton.hidden = NO;
    _saveTripButton.hidden = YES;
    _discardTripButton.hidden = YES;
    _recordingPreview.hidden = YES;
    _rideNameTextField.enabled = YES;
}

- (void)showRecordingPreviewForRecorder:(BITripRecorder *) tripRecorder {
    _recordingPreview = [[BITripRecordingPreview alloc] initWithTripRecorder:tripRecorder];
    [_recordingPreview clearAnnotations];
    [self.view addSubview:_recordingPreview];
    [_recordingPreview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_stopRecordingButton withOffset:50];
    [_recordingPreview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:VERTICAL_SPACING];
    [_recordingPreview autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_recordingPreview autoPinEdgeToSuperviewEdge:ALEdgeRight];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}




@end