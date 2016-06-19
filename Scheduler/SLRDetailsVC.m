#import "SLRDetailsVC.h"

#import "SLRServiceCell.h"
#import "SLRDetailsPickerView.h"
#import "SLRDetailsServicesView.h"
#import "SLRDetailsSummaryView.h"

@interface SLRDetailsVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *bookButton;

@end

@implementation SLRDetailsVC

- (void)viewDidLoad
{
	self.edgesForExtendedLayout = UIRectEdgeNone;
	self.view.backgroundColor = [UIColor whiteColor];

	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

	[self.tableView registerClass:[SLRServiceCell class] forCellReuseIdentifier:NSStringFromClass([SLRServiceCellVM class])];
	[self.tableView registerClass:[SLRDetailsPickerView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLRDetailsPickerVM class])];
	[self.tableView registerClass:[SLRDetailsServicesView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLRDetailsServicesVM class])];
	[self.tableView registerClass:[SLRDetailsSummaryView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLRDetailsSummaryVM class])];

	self.tableView.tableFooterView = [[UIView alloc] init];
	[self.view addSubview:self.tableView];

	self.bookButton = [[UIButton alloc] init];
	[self.bookButton setTitle:@"Book" forState:UIControlStateNormal];
	[self.bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.bookButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	self.bookButton.backgroundColor = [UIColor dgs_colorWithString:@"1976D2"];
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

	void(^behaviourBlock)(NSNotification *notification) = ^(NSNotification *notification){
		@strongify(self);

		BOOL isShowKeyboardNotification = [notification.name isEqualToString:@"UIKeyboardWillShowNotification"];
		CGFloat keyboardHeight = isShowKeyboardNotification
			? [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height
			: -[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;

		CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
		rect.origin.y -= 200.0;

		rect = isShowKeyboardNotification
			? rect
			: self.tableView.frame;

		self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
		[self.tableView scrollRectToVisible:rect animated:YES];
	};

	[self configureKeyboardBehaviorWithShowBlock:behaviourBlock hideBlock:behaviourBlock];
}

- (void)configureKeyboardBehaviorWithShowBlock:(void (^)(NSNotification *notification))showBlock
									 hideBlock:(void (^)(NSNotification *notification))hideBlock
{
	RACSignal *showSignal =
		[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification
															   object:nil] combineLatestWith:[RACSignal return:[showBlock copy]]];

	RACSignal *hideSignal =
		[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification
															   object:nil] combineLatestWith:[RACSignal return:[hideBlock copy]]];

	[[[showSignal merge:hideSignal]
		takeUntil:self.rac_willDeallocSignal]
		subscribeNext:^(RACTuple *t) {
			RACTupleUnpack(NSNotification *notification, void(^block)(NSNotification *notification)) = t;

			if (block)
			{
				block(notification);
			}
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

@end
