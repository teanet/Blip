#import "SLRVisitorInterval.h"

@implementation SLRVisitorInterval

@synthesize title = _title;
@synthesize color = _color;
@synthesize range = _range;

- (instancetype)initWithTitle:(NSString *)title range:(NSRange)range
{
	self = [super init];
	if (self == nil) return nil;

	_color = [UIColor greenColor];
	_title = title;
	_range = range;

	return self;
}

@end
