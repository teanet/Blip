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

	[self setupReactiveStuff];
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[self.viewModel.initialViewModelSignal
		subscribeNext:^(SLRBaseVM *vm) {
			@strongify(self);

			SLRBaseVC *showVC = [SLRHomeVC viewControllerForViewModel:vm];
			[self dgs_showViewController:showVC inView:self.view];
		}];
}

@end


@implementation SLRHomeVC (SLRHomeVCFabric)

+ (SLRBaseVC *)viewControllerForViewModel:(SLRBaseVM *)viewModel
{
	SLRBaseVC *showVC = nil;

	if ([viewModel isKindOfClass:[SLRSchedulerVM class]])
	{
		showVC = [[SLRSchedulerVC alloc] initWithViewModel:(SLRSchedulerVM *)viewModel];
	}
	else if ([viewModel isKindOfClass:[SLRFilialVM class]])
	{
		showVC = [[SLRFilialVC alloc] initWithViewModel:(SLRFilialVM *)viewModel];
	}

	return showVC;
}

@end
