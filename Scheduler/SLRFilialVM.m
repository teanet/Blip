#import "SLRFilialVM.h"

#import "SLRFilial.h"
#import "SLROwnersVM.h"
#import "SLRPurposesVM.h"
#import "SLRFilialSchedulerVM.h"
#import "SLRFilialOwnersView.h"
#import "SLRFilialPurposesCell.h"

@interface SLRFilialVM () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) SLRFilial *filial;
@property (nonatomic, copy, readonly) NSString *ownerHeaderIdentifier;
@property (nonatomic, copy, readonly) NSString *purposesCellIdentifier;

@end

@implementation SLRFilialVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_filial = filial;
	_ownersVM = [[SLROwnersVM alloc] initWithOwners:filial.owners];
	_purposesVM = [[SLRPurposesVM alloc] initWithPurposes:filial.purposes];

	_ownerHeaderIdentifier = NSStringFromClass([SLRFilialOwnersView class]);
	_purposesCellIdentifier = NSStringFromClass([SLRFilialPurposesCell class]);

	[self setupReactiveStuff];

	return self;
}

- (void)setupReactiveStuff
{
	RACSignal *shouldShowSchedulerForOwnerSignal = [self.ownersVM.didSelectOwnerSignal
		map:^SLRSchedulerVM *(SLROwner *owner) {
			return nil;//[[SLRSchedulerVM alloc] initWithOwner:owner];
		}];

	RACSignal *shouldShowSchedulerForPurposeSignal = [self.purposesVM.didSelectPurposeSignal
		map:^SLRFilialSchedulerVM *(SLRPurpose *purpose) {
			return [[SLRFilialSchedulerVM alloc] initWithPurposes:@[purpose]];
		}];

	_shouldShowSchedulerSignal = [shouldShowSchedulerForOwnerSignal merge:shouldShowSchedulerForPurposeSignal];
}

- (NSString *)title
{
	return self.filial.title;
}

- (void)registerTableView:(UITableView *)tableView
{
	[tableView registerClass:[SLRFilialOwnersView class] forHeaderFooterViewReuseIdentifier:self.ownerHeaderIdentifier];
	[tableView registerClass:[SLRFilialPurposesCell class] forCellReuseIdentifier:self.purposesCellIdentifier];
	tableView.delegate = self;
	tableView.dataSource = self;
}

// MARK: TableView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	SLRFilialOwnersView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.ownerHeaderIdentifier];
	headerView.viewModel = self.ownersVM;
	return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SLRFilialPurposesCell *cell = [tableView dequeueReusableCellWithIdentifier:self.purposesCellIdentifier];
	cell.viewModel = self.purposesVM;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	CGFloat returnHeight = 0.0;

	if (section == 0)
	{
		returnHeight = self.filial.owners.count > 1
			? 70.0
			: 0.0;
	}

	return returnHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.purposesVM.contentHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
