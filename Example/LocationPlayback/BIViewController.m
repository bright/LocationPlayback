//
//  BIViewController.m
//  LocationPlayback
//
//  Created by Daniel Makurat on 06/22/2015.
//  Copyright (c) 2014 Daniel Makurat. All rights reserved.
//

#import <LocationPlayback/BITripRecorder.h>
#import <LocationPlayback/BITripPlayback.h>
#import <LocationPlayback/BITripRecordingPreview.h>
#import <LocationPlayback/BITripPlaybackPreview.h>
#import "BIViewController.h"

@interface BIViewController ()

@end

@implementation BIViewController {
    BITripRecorder *_tripRecorder;
    BITripPlayback *_tripPlayback;
    BITripRecordingPreview *_recordingPreview;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tripRecorder = [[BITripRecorder alloc] init];


    [self performSelector:@selector(stopRecordingTrip) withObject:nil afterDelay:15];
    _recordingPreview = [[BITripRecordingPreview alloc] initWithTripRecorder:_tripRecorder];
    [self.view addSubview:_recordingPreview];

    [_tripRecorder start];
}

- (void)stopRecordingTrip {
    BITrip *trip = [_tripRecorder stop];
    _tripPlayback = [[BITripPlayback alloc] initWithTrip:trip];
    [_recordingPreview removeFromSuperview];
    _recordingPreview = nil;

    BITripPlaybackPreview *playbackPreview = [[BITripPlaybackPreview alloc] initWithTripPlayback:_tripPlayback];
    [self.view addSubview: playbackPreview];
    [_tripPlayback play];
}

@end
