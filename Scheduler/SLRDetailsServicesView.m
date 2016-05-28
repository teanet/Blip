#import "SLRDetailsServicesView.h"

@interface SLRDetailsServicesView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SLRDetailsServicesView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [UIColor lightGrayColor];

	self.titleLabel = [[UILabel alloc] init];
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:self.titleLabel];

	[self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
												forAxis:UILayoutConstraintAxisVertical];
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.contentView);
	}];

	return self;
}

- (void)setViewModel:(SLRDetailsServicesVM *)viewModel
{
	[super setViewModel:viewModel];
	self.titleLabel.text = viewModel.title;
}

@end
