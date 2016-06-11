#import "SLRFilialVC.h"

#import "SLROwnersVC.h"
#import "SLRSchedulerVC.h"
#import "UIViewController+DGSAdditions.h"

@interface SLRFilialVC () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *ownersContainerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SLRFilialVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = self.viewModel.title;

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self setupInterface];

	[self setupReactiveStuff];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)setupInterface
{
	self.view.backgroundColor = [UIColor whiteColor];
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	self.tableView.tableFooterView = [[UIView alloc] init];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:self.tableView];
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[self.viewModel registerTableView:self.tableView];
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[self.viewModel.shouldShowSchedulerSignal
		subscribeNext:^(SLRSchedulerVM *viewModel) {
			@strongify(self);

			SLRSchedulerVC *vc = [[SLRSchedulerVC alloc] initWithViewModel:viewModel];
			[self.navigationController pushViewController:vc animated:YES];
		}];
}

@end
