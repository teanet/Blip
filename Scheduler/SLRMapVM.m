#import "SLRMapVM.h"

@implementation SLRMapVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_location = [[CLLocation alloc] initWithLatitude:55.4521 longitude:37.3704];

	return self;
}

@end
