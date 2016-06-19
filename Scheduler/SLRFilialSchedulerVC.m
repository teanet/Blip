#import "SLRFilialSchedulerVC.h"

#import "SLROwnersVC.h"
#import "SLRSchedulerVC.h"
#import "UIViewController+DGSAdditions.h"
#import "SLRDetailsVC.h"
#import "SLRDataProvider.h"

@interface SLRFilialSchedulerVC ()

@property (nonatomic, strong) UIView *ownersViewContainer;
@property (nonatomic, strong) UIView *schedulerViewContainer;
@property (nonatomic, strong, readonly) SLROwnersVC *ownersVC;
@property (nonatomic, strong, readonly) SLRSchedulerVC *schedulerVC;

@end

@implementation SLRFilialSchedulerVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	_ownersVC = [[SLROwnersVC alloc] initWithViewModel:self.viewModel.ownersVM];
	_schedulerVC = [[SLRSchedulerVC alloc] initWithViewModel:self.viewModel.schedulerVM];

	[self setupReactiveStuff];

	return self;
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[self.viewModel.shouldShowDetailsSignal
		subscribeNext:^(SLRDetailsVM *detailsVM) {
			@strongify(self);

			[self showDetailsVCForViewModel:detailsVM];
		}];
}

- (void)showDetailsVCForViewModel:(SLRDetailsVM *)detailsVM
{
	@weakify(self);

	[detailsVM.didBookSignal
		subscribeNext:^(id _) {
			@strongify(self);

			[self done];
		}];

	SLRDetailsVC *vc = [[SLRDetailsVC alloc] initWithViewModel:detailsVM];

#warning (vadim.smirnov) Убрать безобразие
	UIImage *closeImage = [UIImage imageNamed:@"closeImage"];
	UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:closeImage
																  style:UIBarButtonItemStyleDone
																 target:self
																 action:@selector(done)];
	[vc.navigationItem setLeftBarButtonItem:closeItem];

	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nc animated:YES completion:nil];
}

- (void)done
{
	@weakify(self);

	[self dismissViewControllerAnimated:YES completion:^{
		@strongify(self);

		[self.viewModel reloadCurrentPage];
		[[SLRDataProvider sharedProvider] scheduleNotification];
	}];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];
	self.ownersViewContainer = [[UIView alloc] init];
	[self.view addSubview:self.ownersViewContainer];

	self.schedulerViewContainer = [[UIView alloc] init];
	[self.view addSubview:self.schedulerViewContainer];

	CGFloat ownersContainerHeight = self.viewModel.shouldShowOwnersPicker ? 150.0 : 0.0;
	[self.ownersViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view).with.offset(64.0);
		make.leading.equalTo(self.view);
		make.trailing.equalTo(self.view);
		make.height.equalTo(@(ownersContainerHeight));
	}];

	[self.schedulerViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.ownersViewContainer.mas_bottom);
		make.leading.equalTo(self.view);
		make.trailing.equalTo(self.view);
		make.bottom.equalTo(self.view).with.offset(-49.0);
	}];

	[self dgs_showViewController:self.ownersVC inView:self.ownersViewContainer];
	[self dgs_showViewController:self.schedulerVC inView:self.schedulerViewContainer];
}

@end
