#import <Foundation/Foundation.h>

@protocol BITripRepository;
@protocol BITripRepositoryBuilder;


@interface BILocationPlaybackConfiguration : NSObject

@property (nonatomic) CGSize previewSize;

- (void)setTripRepositoriesBuilder:(id <BITripRepositoryBuilder>)repositoryBuilder;

- (id <BITripRepository>)createStorage;

@end