#import "SLRAboutVM.h"

#import "SLRFilial.h"
#import "SLRMapVM.h"

#import "SLRStatusBarHeaderView.h"
#import "SLRFilialInfoHeaderView.h"

typedef NS_ENUM(NSUInteger, SLRAboutSection) {
	// Порядок важен - в таком порядке будут отображаться секции в таблице
	SLRAboutSectionInfo = 0,
	SLRAboutSectionStatusBar = 1,

	// Порядок важен - это должен быть последний элемент в енуме
	SLRAboutSectionCountOfSections
};

@interface SLRAboutVM () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) SLRFilial *filial;
@property (nonatomic, copy, readonly) NSString *infoHeaderIdentifier;
@property (nonatomic, copy, readonly) NSString *statusBarHeaderIdentifier;

@end

@implementation SLRAboutVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_title = @"Company";
	_filial = filial;
	_mapVM = [[SLRMapVM alloc] initWithFilial:filial];

	_infoHeaderIdentifier = NSStringFromClass([SLRStatusBarHeaderView class]);
	_statusBarHeaderIdentifier = NSStringFromClass([SLRFilialInfoHeaderView class]);

	return self;
}

// MARL: Table View

- (void)registerTableView:(UITableView *)tableView
{
	[tableView registerClass:[SLRFilialInfoHeaderView class] forHeaderFooterViewReuseIdentifier:self.infoHeaderIdentifier];
	[tableView registerClass:[SLRStatusBarHeaderView class] forHeaderFooterViewReuseIdentifier:self.statusBarHeaderIdentifier];

	tableView.delegate = self;
	tableView.dataSource = self;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	SLRTableViewHeaderFooterView *headerView = nil;

	if (section == SLRAboutSectionInfo)
	{
		headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.infoHeaderIdentifier];
//		headerView.viewModel = self.ownersVM;
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
//	SLRFilialPurposesCell *cell = [tableView dequeueReusableCellWithIdentifier:self.purposesCellIdentifier];
//	cell.viewModel = self.purposesVM;
//	return cell;

	static NSString *simpleTableIdentifier = @"SimpleTableItem";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:simpleTableIdentifier];
	}

	cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
	return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	CGFloat returnHeight = 0.0;

	if (section == SLRAboutSectionInfo)
	{
		returnHeight = 100.0;
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
	return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == SLRAboutSectionStatusBar)
	{
		return 100;
	}
	else
	{
		return 0;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
