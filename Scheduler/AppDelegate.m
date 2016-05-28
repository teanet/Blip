#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "SLRRootVC.h"
#import "SLRSchedulerVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//	[[Fabric sharedSDK] setDebug:YES];
//	[Fabric with:@[CrashlyticsKit]];

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

//	NSError *error = nil;
//	NSDictionary *d = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"schedule_params.json" ofType:nil]] options:0 error:&error];
//	SLRScheduleModel *model = [[SLRScheduleModel alloc] initWithDictionary:d];
	SLRSchedulerVM *schedulerVM = [[SLRSchedulerVM alloc] initWithPage:[SLRPage pageTest]];
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SLRSchedulerVC alloc] initWithViewModel:schedulerVM]];
	[self.window makeKeyAndVisible];

	return YES;
}


@end
