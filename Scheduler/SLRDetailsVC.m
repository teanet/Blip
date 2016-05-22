#import "SLRDetailsVC.h"

@interface SLRDetailsVC ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SLRDetailsVC

- (void)viewDidLoad
{
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	[self.view addSubview:self.tableView];

	// Layout
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

@end
