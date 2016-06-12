#import "SLRPurposesVM.h"

#import "SLRPurposeCell.h"

static CGFloat const kPurposeCellHeight = 200.0;

@interface SLRPurposesVM () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy, readonly) NSArray <SLRPurpose *> *purposes;
@property (nonatomic, copy, readonly) NSArray <SLRPurposeCellVM *> *purposeVMs;
@property (nonatomic, copy, readonly) NSString *purposeCellIdentifier;


@end

@implementation SLRPurposesVM

- (instancetype)initWithPurposes:(NSArray <SLRPurpose *> *)purposes
{
	self = [super init];
	if (self == nil) return nil;

	_purposes = [purposes copy];
	_purposeCellIdentifier = NSStringFromClass([SLRPurposeCellVM class]);

	_purposeVMs = [[purposes rac_sequence]
	   map:^SLRPurposeCellVM *(SLRPurpose *purpose) {
		   return [[SLRPurposeCellVM alloc] initWithPurpose:purpose];
	   }].array;

	_didSelectPurposeSignal = [[[self rac_signalForSelector:@checkselector(self, didSelectPurpose:)]
		map:^SLRPurpose *(RACTuple *tuple) {
			return tuple.first;
		}]
		ignore:nil];

	return self;
}

- (void)didSelectPurpose:(SLRPurpose *)purpose
{
}

- (void)registerTableView:(UITableView *)tableView
{
	[tableView registerClass:[SLRPurposeCell class] forCellReuseIdentifier:self.purposeCellIdentifier];
	tableView.delegate = self;
	tableView.dataSource = self;
}

- (CGFloat)contentHeight
{
	return self.purposeVMs.count * kPurposeCellHeight;
}

// MARK: TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kPurposeCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.purposeVMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SLRPurposeCell *cell = [tableView dequeueReusableCellWithIdentifier:self.purposeCellIdentifier];
	cell.viewModel = [self.purposeVMs objectAtIndex:indexPath.row];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	SLRPurpose *purpose = nil;

	if (indexPath.row < self.purposes.count)
	{
		purpose = [self.purposes objectAtIndex:indexPath.row];
	}

	[self didSelectPurpose:purpose];
}

@end
