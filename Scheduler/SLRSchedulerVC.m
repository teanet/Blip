#import "SLRSchedulerVC.h"

#import "SLRIntervalView.h"
#import "SLRWorkDayVM.h"
#import "SLRSeporatorView.h"

CGFloat const kIntervalViewDefaultHeight = 50.0;
CGFloat const kIntervalViewDefaultInset = 50.0;

@interface SLRSchedulerVC ()

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) SLRWorkDayVM *workDayVM;

@end

@implementation SLRSchedulerVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	_workDayVM = [[SLRWorkDayVM alloc] init];

	return self;
}

- (void)loadView
{
	_scrollView = [[UIScrollView alloc] init];
	_contentView = [[UIView alloc] init];
	self.view = [[UIView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];

	[self.view addSubview:self.scrollView];
	[self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	self.contentView.backgroundColor = [UIColor grayColor];
	self.contentView.userInteractionEnabled = YES;
	[self.scrollView addSubview:self.contentView];
	[self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@1440);
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		make.edges.equalTo(self.scrollView);
	}];

	for (int i = 0; i<24; i++)
	{
		SLRSeporatorView *v = [[SLRSeporatorView alloc] init];
		v.text = [NSString stringWithFormat:@"%d", i];
		[self.contentView addSubview:v];
		[v mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.equalTo(self.contentView.mas_top).with.offset(i*60);
			make.leading.equalTo(self.contentView);
			make.trailing.equalTo(self.contentView);
		}];
	}

	UILongPressGestureRecognizer *lpGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
	[self.contentView addGestureRecognizer:lpGR];

}

- (void)longPress:(UILongPressGestureRecognizer *)lpGR
{
	if (lpGR.state == UIGestureRecognizerStateBegan)
	{
		SLRIntervalView *iv = [self newIntervalViewAtLocation:[lpGR locationInView:lpGR.view]];
	}
}

- (void)panIntervalView:(UIPanGestureRecognizer *)panGR
{
	SLRIntervalView *iv = (SLRIntervalView *)panGR.view;
	SLRIntervalVM *intervalVM = iv.intervalVM;

	if (panGR.state == UIGestureRecognizerStateBegan)
	{
		[self.contentView bringSubviewToFront:iv];
	}
	else if (panGR.state == UIGestureRecognizerStateChanged)
	{
		CGPoint translation = [panGR translationInView:panGR.view];
		NSInteger deltaMinutes = slr_minutesFromPoints(translation.y);
		[self.workDayVM interval:intervalVM didUpdateLocation:intervalVM.range.location + deltaMinutes];
		[panGR setTranslation:CGPointZero inView:panGR.view];
	}
	else if (panGR.state == UIGestureRecognizerStateEnded ||
			 panGR.state == UIGestureRecognizerStateCancelled)
	{
		[self.workDayVM intervalDidEndDragging:intervalVM];
	}
}

- (SLRIntervalView *)newIntervalViewAtLocation:(CGPoint)location
{
	SLRRange *range = [[SLRRange alloc] init];
	range.location = slr_minutesFromPoints(location.y);
	range.length = 30;

	NSArray *intervals = [self.workDayVM intervalsVMAtRange:range];
	if (intervals.count > 0) return nil;

	SLRIntervalVM *intervalVM = [[SLRIntervalVM alloc] init];
	intervalVM.range = range;

	SLRIntervalView *intervalView = [[SLRIntervalView alloc] init];
	intervalView.frame = CGRectMake(kIntervalViewDefaultInset, 0.0, CGRectGetWidth(self.view.frame) - kIntervalViewDefaultInset, kIntervalViewDefaultHeight);
	intervalView.intervalVM = intervalVM;

	[self.workDayVM insertInterval:intervalVM];

	UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panIntervalView:)];
	[intervalView addGestureRecognizer:panGR];

	[self.contentView addSubview:intervalView];
	return intervalView;
}

@end
