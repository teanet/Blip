#import "SLRRootVC.h"

#import "SLRSchedulerVC.h"
#import "SLRAppointmentsVC.h"
#import "SLRAboutVC.h"
#import "SLRStoreVC.h"
#import "SLRHomeVC.h"
#import "SLRLoaderView.h"
#import "UIViewController+DGSAdditions.h"

@interface SLRRootVC ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) SLRLoaderView *loaderView;

@end

@implementation SLRRootVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	[self waitForViewModels];

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.containerView = [[UIView alloc] init];
	[self.view addSubview:self.containerView];

	[self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	self.loaderView = [[SLRLoaderView alloc] init];
	[self.view addSubview:self.loaderView];

	[self.loaderView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

- (void)waitForViewModels
{
	@weakify(self);

	[[[RACObserve(self.viewModel, readyToUse)
		ignore:@NO]
		deliverOnMainThread]
		subscribeNext:^(id _) {
			@strongify(self);

			SLRAboutVC *aboutVC = [[SLRAboutVC alloc] initWithViewModel:self.viewModel.aboutVM];
			SLRAppointmentsVC *appointmentsVC = [[SLRAppointmentsVC alloc] initWithViewModel:self.viewModel.appointmentsVM];
			SLRHomeVC *homeVC = [[SLRHomeVC alloc] initWithViewModel:self.viewModel.homeVM];

			UITabBarController *tc = [[UITabBarController alloc] init];
			tc.viewControllers = @[aboutVC, homeVC, appointmentsVC];

			[self dgs_showViewController:tc inView:self.containerView];

			[UIView animateWithDuration:0.3 animations:^{
				self.loaderView.alpha = 0.0;
			}];
		}];
}

@end
