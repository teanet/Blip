#import "SLRProjectSettings.h"

@implementation SLRProjectSettings

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	NSDictionary *themeDictionary = dictionary[@"theme"];

	NSString *colorString = themeDictionary[@"navigation_bar_color"];
	if (colorString.length > 0)
	{
		_navigaitionBarColor = [UIColor dgs_colorWithString:colorString];
	}
	else
	{
		_navigaitionBarColor = [UIColor darkGrayColor];
	}

	return self;
}

@end
