#import "SLRRootVC.h"

#import "SLRSchedulerVC.h"
#import "SLRRequestsVC.h"
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

	SLRStoreVM *storeVM = [[SLRStoreVM alloc] init];
	SLRStoreVC *storeVC = [[SLRStoreVC alloc] initWithViewModel:storeVM];

	SLRRequestsVM *requestsVM = [[SLRRequestsVM alloc] init];
	SLRRequestsVC *requestsVC = [[SLRRequestsVC alloc] initWithViewModel:requestsVM];

	SLRHomeVM *homeVM = [[SLRHomeVM alloc] init];
	SLRHomeVC *homeVC = [[SLRHomeVC alloc] initWithViewModel:homeVM];

	UITabBarController *tc = [[UITabBarController alloc] init];
	tc.viewControllers = @[homeVC, storeVC, requestsVC];

	[self dgs_showViewController:tc inView:self.view];

	return self;
}

@end
