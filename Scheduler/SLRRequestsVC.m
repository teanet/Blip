#import "SLRRequestsVC.h"

@interface SLRRequestsVC ()

@end

@implementation SLRRequestsVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = @"Appointments";

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.view setBackgroundColor:[UIColor brownColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

@end
