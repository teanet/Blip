#import "AppDelegate.h"

#import "SLRRootVC.h"
#import "SLRSchedulerVC.h"

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

	SLRSchedulerVM *schedulerVM = [[SLRSchedulerVM alloc] initWithPage:[SLRPage testPage]];
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SLRSchedulerVC alloc] initWithViewModel:schedulerVM]];
	[self.window makeKeyAndVisible];

	return YES;
}

@end
