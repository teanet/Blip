#import "SLRAboutVM.h"

#import "SLRFilial.h"
#import "SLRMapVM.h"

#import "SLRStatusBarHeaderView.h"
#import "SLRFilialInfoHeaderView.h"
#import "SLRAboutContactCell.h"

typedef NS_ENUM(NSUInteger, SLRAboutSection) {
	// Порядок важен - в таком порядке будут отображаться секции в таблице
	SLRAboutSectionInfo = 0,
	SLRAboutSectionStatusBar = 1,

	// Порядок важен - это должен быть последний элемент в енуме
	SLRAboutSectionCountOfSections
};

@interface SLRAboutVM () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) SLRFilial *filial;
@property (nonatomic, strong, readonly) SLRFilialInfoVM *infoHeaderVM;
@property (nonatomic, strong, readonly) SLRAboutContactCellVM *contactCellVM;
@property (nonatomic, copy, readonly) NSString *infoHeaderIdentifier;
@property (nonatomic, copy, readonly) NSString *statusBarHeaderIdentifier;
@property (nonatomic, copy, readonly) NSString *contactCellIdentifier;

@end

@implementation SLRAboutVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_title = @"О нас";
	_filial = filial;
	_mapVM = [[SLRMapVM alloc] initWithFilial:filial];
	_infoHeaderVM = [[SLRFilialInfoVM alloc] initWithFilial:filial];
	_contactCellVM = [[SLRAboutContactCellVM alloc] initWithFilial:filial];

	_infoHeaderIdentifier = NSStringFromClass([SLRStatusBarHeaderView class]);
	_statusBarHeaderIdentifier = NSStringFromClass([SLRFilialInfoHeaderView class]);
	_contactCellIdentifier = NSStringFromClass([SLRAboutContactCell class]);

	return self;
}

// MARL: Table View

- (void)registerTableView:(UITableView *)tableView
{
	[tableView registerClass:[SLRFilialInfoHeaderView class] forHeaderFooterViewReuseIdentifier:self.infoHeaderIdentifier];
	[tableView registerClass:[SLRStatusBarHeaderView class] forHeaderFooterViewReuseIdentifier:self.statusBarHeaderIdentifier];
	[tableView registerClass:[SLRAboutContactCell class] forCellReuseIdentifier:self.contactCellIdentifier];

	tableView.delegate = self;
	tableView.dataSource = self;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	SLRTableViewHeaderFooterView *headerView = nil;

	if (section == SLRAboutSectionInfo)
	{
		headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.infoHeaderIdentifier];
		headerView.viewModel = self.infoHeaderVM;
	}
	else if (section == SLRAboutSectionStatusBar)
	{
		headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.statusBarHeaderIdentifier];
//		headerView.viewModel = self.ownersVM;
	}

	return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SLRTableViewCell *cell = nil;

	if (indexPath.row == 0)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:self.contactCellIdentifier];
		cell.viewModel = self.contactCellVM;
	}

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	CGFloat returnHeight = 0.0;

	if (section == SLRAboutSectionInfo)
	{
		returnHeight = 205.0;
	}
	else if (section == SLRAboutSectionStatusBar)
	{
		returnHeight = 20.0;
	}

	return returnHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return SLRAboutSectionCountOfSections;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == SLRAboutSectionStatusBar)
	{
		return self.contactCellVM.selected
			? 270.0
			: 70.0;
	}
	else
	{
		return 0;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == SLRAboutSectionStatusBar)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

//	if (indexPath.row == 0)
//	{
//		self.contactCellVM.selected = !self.contactCellVM.selected;
//		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//		[UIView animateWithDuration: 0.3 animations: ^{ [cell.contentView layoutIfNeeded]; }];
//		[tableView beginUpdates];
//		[tableView endUpdates];
//	}
}

@end
