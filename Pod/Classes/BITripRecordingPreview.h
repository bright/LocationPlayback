#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BISimpleTripRecorder.h"


@interface BITripRecordingPreview : UIView <BITripRecorderProtocol>


- (instancetype)initWithTripRecorder:(id<BITripRecorder>)tripRecorder;

- (void)clearAnnotations;
@end