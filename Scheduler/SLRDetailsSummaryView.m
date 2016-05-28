#import "SLRDetailsSummaryView.h"

@interface SLRDetailsSummaryView ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation SLRDetailsSummaryView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	UILabel *titleLabel = [[UILabel alloc] init];
	titleLabel.text = @"Комментарий:";
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.backgroundColor = [UIColor lightGrayColor];
	[self.contentView addSubview:titleLabel];

	self.textView = [[UITextView alloc] init];
	[self.contentView addSubview:self.textView];

	[titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
												forAxis:UILayoutConstraintAxisVertical];
	[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView);
		make.height.equalTo(@30).with.priorityHigh();
		make.left.equalTo(self.contentView);
		make.right.equalTo(self.contentView);
	}];

	[self.textView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
											 forAxis:UILayoutConstraintAxisVertical];
	self.textView.backgroundColor = [UIColor lightTextColor];
	[self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(titleLabel.mas_bottom);
		make.left.equalTo(self.contentView);
		make.right.equalTo(self.contentView);
		make.bottom.equalTo(self.contentView);
	}];

	[self configureReactiveStuff];

	return self;
}

- (void)configureReactiveStuff
{
	@weakify(self);

	[self.textView.rac_textSignal
		subscribeNext:^(NSString *text) {
			@strongify(self);

			self.viewModel.summary = text;
		}];
}

@end
