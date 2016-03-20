#import "SLRFreeInterval.h"

@implementation SLRFreeInterval

@synthesize title = _title;
@synthesize color = _color;
@synthesize range = _range;

- (instancetype)initWithRange:(NSRange)range
{
	self = [super init];
	if (self == nil) return nil;

	_color = [UIColor brownColor];
	_range = range;

	return self;
}

@end
