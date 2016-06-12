#import "SLRFilialSchedulerVC.h"

#import "SLROwnersVC.h"
#import "UIViewController+DGSAdditions.h"

@interface SLRFilialSchedulerVC ()

@property (nonatomic, strong) UIView *ownersViewContainer;
@property (nonatomic, strong, readonly) SLROwnersVC *ownersVC;

@end

@implementation SLRFilialSchedulerVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	_ownersVC = [[SLROwnersVC alloc] initWithViewModel:self.viewModel.ownersVM];

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor brownColor];
	self.ownersViewContainer = [[UIView alloc] init];
	[self.view addSubview:self.ownersViewContainer];

	CGFloat ownersContainerHeight = self.viewModel.shouldShowOwnersPicker ? 70.0 : 0.0;
	[self.ownersViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view).with.offset(64.0);
		make.leading.equalTo(self.view);
		make.trailing.equalTo(self.view);
		make.height.equalTo(@(ownersContainerHeight));
	}];

	[self dgs_showViewController:self.ownersVC inView:self.ownersViewContainer];
}

@end
