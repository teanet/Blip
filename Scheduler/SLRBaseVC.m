#import "SLRBaseVC.h"

@implementation SLRBaseVC

- (instancetype)initWithViewModel:(SLRBaseVM *)viewModel
{
	self = [super initWithNibName:nil bundle:nil];
	if (self == nil) return nil;

	_viewModel = viewModel;

	return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	return [self initWithViewModel:nil];
}

@end
