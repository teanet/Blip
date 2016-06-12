#import "SLRMonthHeaderView.h"

@implementation SLRMonthHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [UIColor grayColor];

	return self;
}

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	self.textLabel.text = self.viewModel.month;
}

@end
