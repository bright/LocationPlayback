#import "BILocationRecordingViewController.h"
#import "BITripRecordingPreview.h"
#import "BITrip.h"
#import "BITripRecorder.h"
#import "BIRecordedTripSummaryView.h"


@implementation BILocationRecordingViewController {

    UIButton *_startRecordingButton;
    UIButton *_stopRecordingButton;
    UIButton *_saveTrip;
    BITripRecorder *_tripRecorder;
    BITripRecordingPreview *_recordingPreview;
    BITrip *_trip;
    BIRecordedTripSummaryView *_summary;
}

- (void)loadView {
    [super loadView];
    
    _startRecordingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [self.view addSubview:_startRecordingButton];
    [_startRecordingButton addTarget:self action:@selector(_startRecording) forControlEvents:UIControlEventTouchUpInside];

    _stopRecordingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [self.view addSubview:_stopRecordingButton];
    [_stopRecordingButton addTarget:self action:@selector(_stopRecording) forControlEvents:UIControlEventTouchUpInside];
    _stopRecordingButton.hidden = YES;
    
}

- (void)_stopRecording {
    _trip = [_tripRecorder stop];
    _stopRecordingButton.hidden = YES;

    _summary = [[BIRecordedTripSummaryView alloc] initWithFrame:self.view.bounds trip: _trip];
    _summary.delegate = self;
    [self.view addSubview: _summary];
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
    _recordingPreview.frame = CGRectMake(100, 0, 200, 200);
}


@end