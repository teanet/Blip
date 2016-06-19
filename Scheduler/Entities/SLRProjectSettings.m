#import "SLRProjectSettings.h"

@implementation SLRProjectSettings

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	NSDictionary *themeDictionary = dictionary[@"theme"];

	NSString *colorString = themeDictionary[@"navigation_bar_color"];
	if (colorString.length > 5)
	{
		_navigaitionBarColor = [UIColor dgs_colorWithString:colorString];
	}
	else
	{
		_navigaitionBarColor = [UIColor grayColor];
	}

	NSString *bgColorString = themeDictionary[@"navigation_bar_bgcolor"];
	if (bgColorString.length > 5)
	{
		_navigaitionBarBGColor = [UIColor dgs_colorWithString:bgColorString];
	}
	else
	{
		_navigaitionBarBGColor = [UIColor darkGrayColor];
	}

	return self;
}

@end
