#import "BILocationRecordingViewController.h"
#import "BITripRecordingPreview.h"
#import "BITrip.h"
#import "BITripRecorder.h"
#import "BITripSummaryView.h"


@implementation BILocationRecordingViewController {

    UIButton *_startRecordingButton;
    UIButton *_stopRecordingButton;
    UIButton *_saveTrip;
    BITripRecorder *_tripRecorder;
    BITripRecordingPreview *_recordingPreview;
    BITrip *_trip;
    BITripSummaryView *_summary;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor redColor];
    
    _startRecordingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _startRecordingButton.frame = CGRectMake(0, 100, 200, 70);
    [_startRecordingButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.view addSubview:_startRecordingButton];
    [_startRecordingButton addTarget:self action:@selector(_startRecording) forControlEvents:UIControlEventTouchUpInside];

    _stopRecordingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stopRecordingButton.frame = CGRectMake(0, 100, 200, 70);
    [_stopRecordingButton setTitle:@"Stop" forState:UIControlStateNormal];
    [self.view addSubview:_stopRecordingButton];
    [_stopRecordingButton addTarget:self action:@selector(_stopRecording) forControlEvents:UIControlEventTouchUpInside];
    _stopRecordingButton.hidden = YES;
    
}

- (void)_stopRecording {
    _trip = [_tripRecorder stop];
    _stopRecordingButton.hidden = YES;
    [self.delegate recordingVC: self tripRecorded: _trip];

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
    _recordingPreview.frame = CGRectMake(100, 200, 200, 300);
}


@end