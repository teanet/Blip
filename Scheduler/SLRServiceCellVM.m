#import "SLRServiceCellVM.h"

@implementation SLRServiceCellVM

@synthesize delegate = _delegate;

- (instancetype)initWithService:(SLRService *)service
{
	self = [super init];
	if (self == nil) return nil;

	_service = service;

	return self;
}

- (void)didSelect
{
	self.service.selected = !self.service.selected;
	[self.delegate updateState];
}

@end
