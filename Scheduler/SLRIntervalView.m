#import "SLRIntervalView.h"

#import "SLRWorkDayVM.h"

CGFloat const kPointsInMinute = 1.0;

CGFloat slr_pointsFromMinutes(NSInteger minutes)
{
	return minutes * kPointsInMinute;
}

CGFloat slr_minutesFromPoints(CGFloat points)
{
	return points / kPointsInMinute;
}

@interface SLRIntervalView ()

@property (nonatomic, strong, readonly) UIView *topView;
@property (nonatomic, strong, readonly) UIView *bottomView;

@end

@implementation SLRIntervalView

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	self.backgroundColor = [UIColor whiteColor];
	self.layer.borderColor = [UIColor blackColor].CGColor;
	self.layer.borderWidth = 1.0;
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOffset = CGSizeMake(5.0, 5.0);

	_topView = [self newSlideView];
	_topView.tag = 0;
	[_topView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.mas_top);
		make.centerX.equalTo(self.mas_left).with.offset(20.0);
	}];

	_bottomView = [self newSlideView];
	_bottomView.tag = 1;
	[_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.mas_bottom);
		make.centerX.equalTo(self.mas_right).with.offset(-20.0);
	}];

	return self;
}

- (UIView *)newSlideView
{
	UIView *view = [[UIView alloc] init];
	UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
	[view addGestureRecognizer:panGR];
	[self addSubview:view];
	view.backgroundColor = [UIColor greenColor];
	[view mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.equalTo(@30.0);
		make.height.equalTo(@30.0);
	}];
	return view;
}

- (void)setIntervalVM:(SLRIntervalVM *)intervalVM
{
	@weakify(self);
	_intervalVM = intervalVM;
	[[RACObserve(intervalVM, range)
		takeUntil:[self rac_signalForSelector:@selector(setIntervalVM:)]]
		subscribeNext:^(SLRRange *range) {
			@strongify(self);

			CGRect frame = self.frame;
			frame.origin.y = slr_pointsFromMinutes(range.location);
			frame.size.height = slr_pointsFromMinutes(range.length);
			self.frame = frame;
		}];

	[[RACObserve(intervalVM, editing)
		takeUntil:[self rac_signalForSelector:@selector(setIntervalVM:)]]
		subscribeNext:^(NSNumber *editing) {
			@strongify(self);

			if (editing.boolValue)
			{
				self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
				self.layer.shadowOpacity = 0.5f;
			}
			else
			{
				self.layer.shadowOpacity = 0.0f;
			}
		}];
}

- (void)pan:(UIPanGestureRecognizer *)panGR
{
	if (panGR.state == UIGestureRecognizerStateChanged)
	{
		SLRRange *range = self.intervalVM.range;
		NSInteger deltaMinutes = slr_minutesFromPoints([panGR translationInView:self].y);

		if (panGR.view.tag == 0)
		{
			[range dragUp:deltaMinutes];
		}
		else
		{
			[range dragDown:deltaMinutes];
		}
		[panGR setTranslation:CGPointZero inView:self];
		[self.intervalVM.workDayVM interval:self.intervalVM didChangeRange:range];
	}
	else if (panGR.state == UIGestureRecognizerStateEnded ||
			 panGR.state == UIGestureRecognizerStateCancelled)
	{
		[self.intervalVM.workDayVM intervalDidEndDragging:self.intervalVM];
	}
}

@end
