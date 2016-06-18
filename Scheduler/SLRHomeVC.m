#import "SLRHomeVC.h"

#import "SLRSchedulerVC.h"
#import "SLRFilialVC.h"
#import "UIViewController+DGSAdditions.h"

@interface SLRHomeVC (SLRHomeVCFabric)

+ (SLRBaseVC *)viewControllerForViewModel:(SLRBaseVM *)viewModel;

@end


@interface SLRHomeVC ()

@end

@implementation SLRHomeVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = @"Home";

	return self;
}

- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor grayColor];
	UIViewController *showVC = [SLRHomeVC viewControllerForViewModel:self.viewModel.showViewModel];
	[self dgs_showViewController:showVC inView:self.view];
}

@end


@implementation SLRHomeVC (SLRHomeVCFabric)

+ (UIViewController *)viewControllerForViewModel:(SLRBaseVM *)viewModel
{
	UIViewController *showVC = nil;

	if ([viewModel isKindOfClass:[SLRSchedulerVM class]])
	{
		showVC = [[SLRSchedulerVC alloc] initWithViewModel:(SLRSchedulerVM *)viewModel];
	}
	else if ([viewModel isKindOfClass:[SLRFilialVM class]])
	{
		SLRFilialVC *filialVC = [[SLRFilialVC alloc] initWithViewModel:(SLRFilialVM *)viewModel];
		UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:filialVC];
		showVC = nc;
	}

	return showVC;
}

@end
