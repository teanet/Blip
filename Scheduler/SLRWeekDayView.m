#import "SLRWeekDayView.h"

#import "SLRDataProvider.h"

@implementation SLRWeekDayView

- (instancetype)init
{
	self = [super initWithFrame:CGRectZero];
	if (self == nil) return nil;

	@weakify(self);

	self.titleLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:14.0];
	[self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

	UIView *selectedView = [[UIView alloc] init];
	selectedView.backgroundColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarBGColor;
	selectedView.layer.cornerRadius = 20.0;
	selectedView.userInteractionEnabled = NO;
	[self insertSubview:selectedView belowSubview:self.titleLabel];

	[selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.titleLabel);
		make.size.mas_equalTo(CGSizeMake(40.0, 40.0));
	}];

	[[RACObserve(self, viewModel.selected)
		ignore:nil]
		subscribeNext:^(NSNumber *selectedNumber) {
			@strongify(self);

			selectedView.hidden = !selectedNumber.boolValue;
			self.titleLabel.font = selectedNumber.boolValue
				? [UIFont dgs_boldDisplayTypeFontOfSize:14.0]
				: [UIFont dgs_regularDisplayTypeFontOfSize:14.0];

			UIColor *titleColor = selectedNumber.boolValue
				? [UIColor whiteColor]
				: [UIColor blackColor];

			[self setTitleColor:titleColor forState:UIControlStateNormal];
		}];

	return self;
}

- (void)setViewModel:(SLRWeekDayVM *)viewModel
{
	_viewModel = viewModel;
	self.alpha = viewModel.interactive
		? 1.0
		: 0.0;
	self.userInteractionEnabled = self.viewModel.interactive;
	[self setTitle:viewModel.title forState:UIControlStateNormal];
}

@end
