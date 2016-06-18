#import "SLRStatusBarHeaderView.h"

#import "SLRDataProvider.h"

@implementation SLRStatusBarHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarColor;

	return self;
}

@end
