//
//  BIViewController.m
//  LocationPlayback
//
//  Created by Daniel Makurat on 06/22/2015.
//  Copyright (c) 2014 Daniel Makurat. All rights reserved.
//

#import <LocationPlayback/TripRecorder.h>
#import <LocationPlayback/TripPlayback.h>
#import "BIViewController.h"

@interface BIViewController ()

@end

@implementation BIViewController {
    TripRecorder *_tripRecorder;
    TripPlayback *_tripPlayback;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tripRecorder = [[TripRecorder alloc] init];
    [_tripRecorder start];

    [self performSelector:@selector(stopRecordingTrip) withObject:nil afterDelay:15];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)stopRecordingTrip {
    Trip *trip = [_tripRecorder stop];
    _tripPlayback = [[TripPlayback alloc] initWithTrip:trip];
    [_tripPlayback play];
}

@end
