#import "SLRRootVC.h"

#import "SLRSchedulerVC.h"
#import "SLRAppointmentsVC.h"
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

	SLRAppointmentsVM *appointmentsVM = [[SLRAppointmentsVM alloc] init];
	SLRAppointmentsVC *appointmentsVC = [[SLRAppointmentsVC alloc] initWithViewModel:appointmentsVM];

	SLRHomeVM *homeVM = [[SLRHomeVM alloc] init];
	SLRHomeVC *homeVC = [[SLRHomeVC alloc] initWithViewModel:homeVM];

	UITabBarController *tc = [[UITabBarController alloc] init];
	tc.viewControllers = @[homeVC, storeVC, appointmentsVC];

	[self dgs_showViewController:tc inView:self.view];

	[self setupProximity];

	return self;
}

- (void)setupProximity
{
	[[UIDevice currentDevice] setProximityMonitoringEnabled:YES];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(sensorStateChange:)
												 name:@"UIDeviceProximityStateDidChangeNotification"
											   object:nil];
}

- (void)sensorStateChange:(NSNotificationCenter *)notification
{
	if ([[UIDevice currentDevice] proximityState] == YES)
	{
		NSLog(@"Device is close to user.");
	}
	else
	{
		NSLog(@"Device is ~not~ closer to user.");
	}
}



@end
