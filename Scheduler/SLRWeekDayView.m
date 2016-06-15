#import "SLRWeekDayView.h"

@implementation SLRWeekDayView

- (instancetype)init
{
	self = [super initWithFrame:CGRectZero];
	if (self == nil) return nil;

	self.titleLabel.adjustsFontSizeToFitWidth = YES;
	self.layer.borderWidth = 1.0;

	UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
	[self addSubview:button];
	[button mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self);
		make.centerY.equalTo(self.mas_bottom);
	}];

	RAC(button, hidden) = [[RACObserve(self, viewModel.selected)
		ignore:nil]
		not];

	return self;
}

- (void)setViewModel:(SLRWeekDayVM *)viewModel
{
	_viewModel = viewModel;
	self.backgroundColor = viewModel.interactive
		? [UIColor brownColor]
		: [UIColor lightGrayColor];
	self.userInteractionEnabled = self.viewModel.interactive;
	[self setTitle:viewModel.title forState:UIControlStateNormal];
}

@end
