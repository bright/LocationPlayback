#import "BITripSummaryView.h"
#import "BITrip.h"
#import "BIStyles.h"
#import "ALView+PureLayout.h"

#define VERTICAL_SPACING 20
#define LEFT_RIGHT_INSET 20

@implementation BITripSummaryView

- (instancetype)initWithTrip:(BITrip *)trip {
    self = [super init];
    if (self) {
        self.backgroundColor = [BIStyles textFieldsColor];

        UILabel *tripNameLabel = [self createLabel];
        [self addSubview:tripNameLabel];
        tripNameLabel.text = [NSString stringWithFormat:@"Name: %@", [trip getName]];

        [tripNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
        [tripNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
        [tripNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:VERTICAL_SPACING];

        UILabel *entriesCountLabel = [self createLabel];
        [self addSubview:entriesCountLabel];
        NSUInteger locationEntriesCount = [[trip getEntries] count];
        entriesCountLabel.text = [NSString stringWithFormat:@"Entries count: %d", locationEntriesCount];

        [entriesCountLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tripNameLabel withOffset:VERTICAL_SPACING];
        [entriesCountLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
        [entriesCountLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];

        UILabel *tripStartDateLabel = [self createLabel];
        [self addSubview:tripStartDateLabel];
        NSDate *tripStartDate = [trip getStartDate];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd.MM.yyyy HH:mm:ss";
        NSString *startDateString = [dateFormatter stringFromDate:tripStartDate];
        tripStartDateLabel.text = [NSString stringWithFormat:@"Start date: %@", startDateString];

        [tripStartDateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:entriesCountLabel withOffset:VERTICAL_SPACING];
        [tripStartDateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
        [tripStartDateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];

        UILabel *tripEndDateLabel = [self createLabel];
        [self addSubview:tripEndDateLabel];
        NSDate *tripEndDate = [trip getEndDate];
        NSString *endDateString = [dateFormatter stringFromDate:tripEndDate];
        tripEndDateLabel.text = [NSString stringWithFormat:@"End date: %@", endDateString];

        [tripEndDateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tripStartDateLabel withOffset:VERTICAL_SPACING];
        [tripEndDateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:LEFT_RIGHT_INSET];
        [tripEndDateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:LEFT_RIGHT_INSET];
    }

    return self;
}

- (UILabel *)createLabel {
    UILabel *tripNameLabel = [UILabel new];
    tripNameLabel.numberOfLines = 0;
    tripNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return tripNameLabel;
}


- (void)_storeTrip {
//    [self.delegate tripSummary]
}
@end