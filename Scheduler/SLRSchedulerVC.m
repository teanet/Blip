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

	@weakify(self);

	self.edgesForExtendedLayout = UIRectEdgeNone;

	[self setupInterface];

	self.viewModel.indexPathController.delegate = self;
	[self.viewModel registerTableView:self.tableView];
	[self.viewModel.didSelectRangeSignal subscribeNext:^(SLRRange *range) {
		@strongify(self);

		[self showDetailsVCForSelectedRange:range];
	}];
}

- (void)showDetailsVCForSelectedRange:(SLRRange *)range
{
	@weakify(self);

	SLRDetailsVM *vm = [[SLRDetailsVM alloc] initWithPage:self.viewModel.page selectedRange:range];

	[vm.didBookSignal
		subscribeNext:^(id _) {
			@strongify(self);

			[self done];
		}];

	SLRDetailsVC *vc = [[SLRDetailsVC alloc] initWithViewModel:vm];

#warning (vadim.smirnov) Убрать безобразие
	UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
																  style:UIBarButtonItemStyleDone
																 target:self
																 action:@selector(done)];
	[vc.navigationItem setLeftBarButtonItem:closeItem];

	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nc animated:YES completion:nil];
}

- (void)done
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupInterface
{
	self.view.backgroundColor = [UIColor whiteColor];
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	_tableView.tableFooterView = [[UIView alloc] init];
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
