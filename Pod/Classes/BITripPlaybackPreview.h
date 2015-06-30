#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BITripPlayback.h"

@class BITripPlayback;


@interface BITripPlaybackPreview : UIView <BITripPlaybackProtocol>

- (instancetype)initWithTripPlayback:(__weak BITripPlayback *)tripPlayback;

+ (instancetype)previewWithTripPlayback:(__weak BITripPlayback *)tripPlayback;

@end