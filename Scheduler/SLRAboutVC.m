#import "SLRAboutVC.h"

#import "SLRMapVC.h"
#import "SLRDataProvider.h"

@interface SLRAboutVC ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SLRAboutVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	UIImage *aboutImage = [UIImage imageNamed:@"aboutItem"];
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.viewModel.title image:aboutImage tag:0];

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self setupInterface];
	[self setupReactiveStuff];
}

- (void)setupInterface
{
	self.view.backgroundColor = [UIColor darkGrayColor];
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	self.tableView.tableFooterView = [[UIView alloc] init];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.showsVerticalScrollIndicator = NO;
	self.tableView.backgroundColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarColor;
	[self.view addSubview:self.tableView];
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[self.viewModel registerTableView:self.tableView];
}

- (void)setupReactiveStuff
{
//	@weakify(self);
//
//	[self.viewModel.shouldShowSchedulerSignal
//		subscribeNext:^(SLRFilialSchedulerVM *viewModel) {
//			@strongify(self);
//
//			SLRFilialSchedulerVC *vc = [[SLRFilialSchedulerVC alloc] initWithViewModel:viewModel];
//			[self.navigationController pushViewController:vc animated:YES];
//		}];
	
//		[[RACScheduler mainThreadScheduler]
//			afterDelay:1 schedule:^{
//				SLRMapVC *mvc = [[SLRMapVC alloc] initWithViewModel:self.viewModel.mapVM];
//				[self presentViewController:mvc animated:YES completion:nil];
//			}];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

@end
