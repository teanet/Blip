#import "SLRFilialVC.h"

@implementation SLRFilialVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = self.viewModel.title;

	return self;
}

- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor brownColor];
}

@end
