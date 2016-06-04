#import "AppDelegate.h"

#import "SLRRootVC.h"
#import "SLRSchedulerVC.h"
#import "SLRCartVC.h"
#import "SLRStoreVC.h"

#import <Crashlytics/Crashlytics.h>
#import <Fabric/Fabric.h>
#import <DigitsKit/DigitsKit.h>
#import <SSKeychain.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[SSKeychain setAccessibilityType:kSecAttrAccessibleAlwaysThisDeviceOnly];
//	[[Fabric sharedSDK] setDebug:YES];
	[Fabric with:@[CrashlyticsKit, DigitsKit]];
	[[Digits sharedInstance] logOut];

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	SLRStoreVM *storeVM = [[SLRStoreVM alloc] init];
	SLRStoreVC *storeVC = [[SLRStoreVC alloc] initWithViewModel:storeVM];

	SLRCartVM *cartVM = [[SLRCartVM alloc] init];
	SLRCartVC *cartVC = [[SLRCartVC alloc] initWithViewModel:cartVM];

	SLRSchedulerVM *schedulerVM = [[SLRSchedulerVM alloc] init];
	SLRSchedulerVC *schedulerVC = [[SLRSchedulerVC alloc] initWithViewModel:schedulerVM];

	UITabBarController *tc = [[UITabBarController alloc] init];
	tc.viewControllers = @[
		[[UINavigationController alloc] initWithRootViewController:schedulerVC],
		storeVC,
		[[UINavigationController alloc] initWithRootViewController:cartVC],
	];

	self.window.rootViewController = tc;
	[self.window makeKeyAndVisible];

	return YES;
}

@end
