#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BITripsViewControllerProtocol;
@class BITripMetadata;

@interface BITripsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id<BITripsViewControllerProtocol> delegate;
- (instancetype)initWithTripsMetadata:(NSArray *)tripsMetadata;

- (instancetype)enableDelete;

+ (instancetype)controllerWithTripMetadata:(NSArray *)tripMetadata;

@end

@protocol BITripsViewControllerProtocol <NSObject>
- (void)tripsViewController:(BITripsViewController *)controller onTripSelected:(BITripMetadata *)selectedTripMetadata;
- (void)tripsViewController:(BITripsViewController *)controller onTripDeleted:(BITripMetadata *)deleted;
@end