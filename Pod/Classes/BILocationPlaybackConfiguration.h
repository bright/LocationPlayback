#import <Foundation/Foundation.h>

@protocol BITripRepository;
@protocol BILocationPlaybackRegistry;


@interface BILocationPlaybackConfiguration : NSObject

@property (nonatomic) CGSize previewSize;

- (void)setRegistry:(id <BILocationPlaybackRegistry>)registry;

- (id <BILocationPlaybackRegistry>)getRegistry;

@end