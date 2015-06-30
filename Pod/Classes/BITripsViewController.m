#import "BITripsViewController.h"
#import "BITripMetadata.h"

@implementation BITripsViewController {
    NSArray *_tripMetadata;
    UITableView *_tableView;
}

- (instancetype)initWithTripMetadata:(NSArray *)tripMetadata {
    self = [super init];
    if (self) {
        _tripMetadata = tripMetadata;
    }

    return self;
}

+ (instancetype)controllerWithTripMetadata:(NSArray *)tripMetadata {
    return [[self alloc] initWithTripMetadata:tripMetadata];
}


- (void)loadView {
    [super loadView];
    self.title = @"Trips";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview: _tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tripMetadata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BISelectTripView_cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BITripMetadata *metadata = _tripMetadata[(NSUInteger) indexPath.row];
    cell.textLabel.text = [metadata getName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BITripMetadata* tripMetadata = _tripMetadata[(NSUInteger) indexPath.row];
    [self.delegate tripsViewController: self onTripSelected: tripMetadata];
}


@end