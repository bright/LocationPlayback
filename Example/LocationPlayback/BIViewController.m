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
#import <LocationPlayback/BILocationPlaybackMainViewController.h>
#import <LocationPlayback/BILocationPlayback.h>
#import "BIViewController.h"

@interface BIViewController ()

@end

@implementation BIViewController {
    BILocationPlaybackMainViewController *_locationPlaybackVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(openPlayback:)];
    [self.view addGestureRecognizer:pinchGesture];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMiniMap:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)openMiniMap:(id)openMiniMap {
    [[BILocationPlayback instance] showMiniMapPlayback];
}

- (void)openPlayback:(id)openPlayback {
    [[BILocationPlayback instance] show];
}

@end
