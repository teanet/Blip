#import "SLRAppointmentsVC.h"

#import "SLRAppointmentCell.h"

@interface SLRAppointmentsVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) UIButton *authenticateButton;

@end

@implementation SLRAppointmentsVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	UIImage *appImage = [UIImage imageNamed:@"profileItem"];
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.viewModel.title image:appImage tag:0];

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self setupInterface];
}

- (void)setupInterface
{
	self.view.backgroundColor = [UIColor whiteColor];
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	_tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView registerClass:[SLRAppointmentCell class]
		   forCellReuseIdentifier:NSStringFromClass([SLRAppointmentCellVM class])];
	self.tableView.tableFooterView = [[UIView alloc] init];

	_authenticateButton = [[UIButton alloc] init];
	[self.authenticateButton setTitle:@"Представься мразь" forState:UIControlStateNormal];
	[self.authenticateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[self.authenticateButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[self.authenticateButton addTarget:self.viewModel
								action:@checkselector0(self.viewModel, authenticate)
					  forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_authenticateButton];

	[self.view addSubview:_tableView];
	[_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[self.authenticateButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.view);
		make.leading.equalTo(self.view);
		make.trailing.equalTo(self.view);
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

	[self.viewModel.shouldShowAuthenticateButtonSignal
		subscribeNext:^(NSNumber *showNumber) {
			@strongify(self);

			[UIView animateWithDuration:0.3 animations:^{
				self.authenticateButton.alpha = showNumber.boolValue
					? 1.0
					: 0.0;
				self.tableView.alpha = showNumber.boolValue
					? 0.0
					: 1.0;
			}];
		}];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.viewModel updateAppointments];
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
	SLRBaseVM *cellVM = [self.viewModel cellVMForIndexPath:indexPath];

	SLRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([cellVM class])
															 forIndexPath:indexPath];
	cell.viewModel = cellVM;

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.viewModel didSelectRowAtIndexPath:indexPath];
}

@end
