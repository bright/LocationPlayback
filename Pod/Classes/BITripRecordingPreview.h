#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BITripRecorder.h"


@interface BITripRecordingPreview : UIView <BITripRecorderProtocol>


- (instancetype)initWithTripRecorder:(BITripRecorder *)tripRecorder;
@end