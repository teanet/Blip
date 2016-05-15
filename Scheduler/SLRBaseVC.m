#import "SLRBaseVC.h"

@interface SLRBaseVC ()

@property (nonatomic, strong, readonly) SLRBaseVM *viewModel;

@end

@implementation SLRBaseVC

@synthesize viewModel = _viewModel;

- (instancetype)initWithViewModel:(id)viewModel
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

- (id)viewModel
{
	return _viewModel;
}

@end
