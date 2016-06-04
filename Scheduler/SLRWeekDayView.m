#import "SLRWeekDayView.h"

#import "SLRPage.h"

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

	RAC(button, hidden) = [[RACObserve(self, page.selected)
		ignore:nil]
		not];

	return self;
}

- (void)setPage:(SLRPage *)page
{
	_page = page;
	[self setTitle:page.dateString forState:UIControlStateNormal];
}

@end
