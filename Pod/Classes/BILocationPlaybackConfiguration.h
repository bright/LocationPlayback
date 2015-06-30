#import <Foundation/Foundation.h>

@protocol BITripRepository;
@protocol BITripRepositoryBuilder;


@interface BILocationPlaybackConfiguration : NSObject

- (void)setTripRepositoriesBuilder:(id <BITripRepositoryBuilder>)repositoryBuilder;

- (id <BITripRepository>)createStorage;
@end