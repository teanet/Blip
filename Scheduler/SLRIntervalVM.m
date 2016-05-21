#import "SLRIntervalVM.h"

@implementation SLRIntervalVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_range = [[SLRRangeVM alloc] init];

	return self;
}

@end
