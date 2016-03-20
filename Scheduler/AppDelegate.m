#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "SLRRootVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[Fabric sharedSDK] setDebug:YES];
	[Fabric with:@[CrashlyticsKit]];

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SLRRootVC alloc] init]];
	[self.window makeKeyAndVisible];

	return YES;
}


@end
