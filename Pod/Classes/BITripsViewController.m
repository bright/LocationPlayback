#import "BITripsViewController.h"
#import "BITripMetadata.h"

@implementation BITripsViewController {
    NSMutableArray *_tripsMetadata;
    UITableView *_tableView;
    BOOL _deleteEnabled;
}

- (instancetype)initWithTripsMetadata:(NSArray *)tripsMetadata {
    self = [super init];
    if (self) {
        _tripsMetadata = [[NSMutableArray alloc] initWithArray:tripsMetadata];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.allowsMultipleSelectionDuringEditing = NO;
}

- (instancetype)enableDelete {
    _deleteEnabled = YES;
    return self;
}

+ (instancetype)controllerWithTripMetadata:(NSArray *)tripMetadata {
    return [[self alloc] initWithTripsMetadata:tripMetadata];
}

- (void)loadView {
    [super loadView];
    self.title = @"Trips";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tripsMetadata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BISelectTripView_cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.detailTextLabel.text = @"";
    BITripMetadata *metadata = [self getMetadataForIndexPath:indexPath];
    cell.textLabel.text = [metadata getName];
    if([metadata getStartDate]){
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd.MM.yy HH:mm:ss";
        NSString *startDateString = [dateFormatter stringFromDate:[metadata getStartDate]];
        cell.detailTextLabel.text = startDateString;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BITripMetadata *tripMetadata = [self getMetadataForIndexPath:indexPath];
    [self.delegate tripsViewController:self onTripSelected:tripMetadata];
}

- (BITripMetadata *)getMetadataForIndexPath:(NSIndexPath *)indexPath {
    BITripMetadata *tripMetadata = nil;
    @synchronized (_tripsMetadata) {
        tripMetadata = _tripsMetadata[(NSUInteger) indexPath.row];
    }
    return tripMetadata;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _deleteEnabled;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BITripMetadata *tripMetadata = [self getMetadataForIndexPath:indexPath];
        [self.delegate tripsViewController:self onTripDeleted:tripMetadata];
        [_tableView beginUpdates];
        @synchronized (_tripsMetadata) {
            [_tripsMetadata removeObject:tripMetadata];
        }
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];

    }
}

@end