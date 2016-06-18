#import "SLRRootVC.h"

#import "SLRSchedulerVC.h"
#import "SLRAppointmentsVC.h"
#import "SLRAboutVC.h"
#import "SLRStoreVC.h"
#import "SLRHomeVC.h"
#import "UIViewController+DGSAdditions.h"

@interface SLRRootVC ()

@end

@implementation SLRRootVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	[self waitForViewModels];

	return self;
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
			tc.viewControllers = @[aboutVC];//, homeVC, appointmentsVC];

			[self dgs_showViewController:tc inView:self.view];
		}];
}

@end
