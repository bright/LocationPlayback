#import "BITripSummaryView.h"
#import "BITrip.h"


@implementation BITripSummaryView {
    UIButton *_storeTripButton;
}

- (instancetype)initWithFrame:(CGRect)frame trip:(BITrip *)trip {
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfLines = 0;
        [self setText:[NSString stringWithFormat:@"trip name (%@); number of entries (%@)", [trip getName], @([[trip getEntries] count])]];
        self.backgroundColor = [UIColor greenColor];
//        _storeButton = [[UIButton alloc] initWithFrame:<#(CGRect)frame#>]
//        _storeTripButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        _storeTripButton.frame = CGRectMake(0, 100, 200, 70);
//        [_storeTripButton setTitle:@"Store" forState:UIControlStateNormal];
//        [self addSubview:_storeTripButton];
//        [_storeTripButton addTarget:self action:@selector(_storeTrip) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)_storeTrip {
//    [self.delegate tripSummary]
}
@end