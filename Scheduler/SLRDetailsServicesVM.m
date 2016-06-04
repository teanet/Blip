#import "SLRDetailsServicesVM.h"

@implementation SLRDetailsServicesVM

- (instancetype)initWithTitle:(NSString *)title
{
	self = [super init];
	if (self == nil) return nil;

	_title = [title copy];

	return self;
}

@end
