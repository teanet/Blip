#import "SLRFilialInfoHeaderView.h"

#import "SLRDataProvider.h"

@implementation SLRFilialInfoHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarColor;

	return self;
}

@end
