#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BITripPlayback.h"

@class BITripPlayback;


@interface BITripPlaybackPreview : UIView <BITripPlaybackProtocol>

@property (nonatomic) BOOL gesturesEnabled;

- (instancetype)initWithTripPlayback:(__weak BITripPlayback *)tripPlayback gesturesEnabled:(BOOL)gesturesEnabled;

- (void)clearAnnotations;

+ (instancetype)previewWithTripPlayback:(__weak BITripPlayback *)tripPlayback;

- (void)move:(UIPanGestureRecognizer *)sender;

@end