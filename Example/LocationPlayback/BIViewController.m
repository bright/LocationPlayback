//
//  BIViewController.m
//  LocationPlayback
//
//  Created by Daniel Makurat on 06/22/2015.
//  Copyright (c) 2014 Daniel Makurat. All rights reserved.
//

#import "BITripRecorder.h"
#import "BITripPlayback.h"
#import "BIViewController.h"

@interface BIViewController ()

@end

@implementation BIViewController {
    BITripRecorder *_tripRecorder;
    BITripPlayback *_tripPlayback;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tripRecorder = [[BITripRecorder alloc] init];
    [_tripRecorder start];

    [self performSelector:@selector(stopRecordingTrip) withObject:nil afterDelay:15];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)stopRecordingTrip {
    BITrip *trip = [_tripRecorder stop];
    _tripPlayback = [[BITripPlayback alloc] initWithTrip:trip];
    [_tripPlayback play];
}

@end
