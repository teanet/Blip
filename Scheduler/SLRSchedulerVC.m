#import "SLRSchedulerVC.h"

#import "SLRDetailsVM.h"
#import "SLRDetailsVC.h"

@interface SLRSchedulerVC ()

@property (nonatomic, strong, readonly) UITableView *tableView;

@end

@implementation SLRSchedulerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	@weakify(self);

	self.edgesForExtendedLayout = UIRectEdgeNone;

	[self setupInterface];

	[self.viewModel registerTableView:self.tableView];
	[self.viewModel.didSelectRangeSignal subscribeNext:^(SLRRange *range) {
		@strongify(self);

		SLRDetailsVM *vm = [[SLRDetailsVM alloc] initWithPage:self.viewModel.page selectedRange:range];
		SLRDetailsVC *vc = [[SLRDetailsVC alloc] initWithViewModel:vm];

		[self.navigationController pushViewController:vc animated:YES];
	}];
}

- (void)setupInterface
{
	self.view.backgroundColor = [UIColor whiteColor];
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	[self.view addSubview:_tableView];
	[_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

@end
