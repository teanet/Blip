#import "SLRDetailsVC.h"

#import "SLRServiceCell.h"
#import "SLRDetailsPickerView.h"

@interface SLRDetailsVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *bookButton;

@end

@implementation SLRDetailsVC

- (void)viewDidLoad
{
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;

	[self.tableView registerClass:[SLRServiceCell class] forCellReuseIdentifier:NSStringFromClass([SLRServiceCellVM class])];
	[self.tableView registerClass:[SLRDetailsPickerView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLRDetailsPickerVM class])];

	self.tableView.tableFooterView = [[UIView alloc] init];
	[self.view addSubview:self.tableView];

	self.bookButton = [[UIButton alloc] init];
	[self.bookButton setTitle:@"Book" forState:UIControlStateNormal];
	[self.bookButton setBackgroundColor:[UIColor grayColor]];
	[self.bookButton addTarget:self.viewModel action:@selector(didTapBookButton)
			  forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.bookButton];

	// Layout
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view);
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		make.bottom.equalTo(self.bookButton.mas_top);
	}];

	[self.bookButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@40.0);
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		make.bottom.equalTo(self.view);
	}];

	[self setupReactiveStuff];
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[[self.viewModel.shouldUpdateTableViewSignal
		deliverOnMainThread]
		subscribeNext:^(id _) {
			@strongify(self);

			[self.tableView reloadData];
		}];
}

// UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.viewModel numberOfRowsForSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.viewModel numberOfSections];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SLRBaseVM<SLRTableViewCellVMProtocol> *cellVM = [self.viewModel cellVMForIndexPath:indexPath];

	SLRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([cellVM class])
															 forIndexPath:indexPath];
	cell.viewModel = cellVM;
	cellVM.delegate = cell;

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.viewModel didSelectRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	SLRBaseVM *headerVM = [self.viewModel headerVMForSection:section];
	SLRTableViewHeaderFooterView *headerView =
		[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([headerVM class])];
	headerView.viewModel = headerVM;
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return [self.viewModel heightForHeaderInSection:section];
}

@end
