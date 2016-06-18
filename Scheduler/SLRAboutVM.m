#import "SLRAboutVM.h"

#import "SLRMapVM.h"

@interface SLRAboutVM () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SLRAboutVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_title = @"Company";
	_mapVM = [[SLRMapVM alloc] init];

	return self;
}

// MARL: Table View

- (void)registerTableView:(UITableView *)tableView
{
//	[tableView registerClass:[SLRFilialOwnersView class] forHeaderFooterViewReuseIdentifier:self.ownerHeaderIdentifier];
//	[tableView registerClass:[SLRFilialPurposesCell class] forCellReuseIdentifier:self.purposesCellIdentifier];
	tableView.delegate = self;
	tableView.dataSource = self;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//	SLRFilialOwnersView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.ownerHeaderIdentifier];
//	headerView.viewModel = self.ownersVM;
//	return headerView;
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//	SLRFilialPurposesCell *cell = [tableView dequeueReusableCellWithIdentifier:self.purposesCellIdentifier];
//	cell.viewModel = self.purposesVM;
//	return cell;
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	CGFloat returnHeight = 0.0;

//	if (section == 0)
//	{
//		returnHeight = self.filial.owners.count > 1
//			? 70.0
//			: 0.0;
//	}

	return returnHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
