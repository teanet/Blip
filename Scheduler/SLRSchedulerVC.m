#import "SLRSchedulerVC.h"

#import "SLRDetailsVM.h"
#import "SLRDetailsVC.h"

@interface SLRSchedulerVC () <TLIndexPathControllerDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

@end

@implementation SLRSchedulerVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = self.viewModel.title;
	self.tabBarItem.title = @"Scheduler";
	self.tabBarItem.image = [UIImage imageNamed:@"cart"];

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.edgesForExtendedLayout = UIRectEdgeNone;

	[self setupInterface];

	self.viewModel.indexPathController.delegate = self;
	[self.viewModel registerTableView:self.tableView];
}

- (void)setupInterface
{
	self.view.backgroundColor = [UIColor whiteColor];
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	_tableView.tableFooterView = [[UIView alloc] init];
	_tableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_tableView];
	[_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

#pragma mark TLIndexPathControllerDelegate

- (void)controller:(TLIndexPathController *)controller didUpdateDataModel:(TLIndexPathUpdates *)updates
{
	[updates performBatchUpdatesOnTableView:self.tableView withRowAnimation:UITableViewRowAnimationFade];
}

@end
