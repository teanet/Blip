#import "SLRWeekHeaderView.h"

#import "SLRWeekDayView.h"

@interface SLRWeekHeaderView ()

@property (nonatomic, strong, readonly) NSMutableArray<SLRWeekDayView *> *days;

@end

@implementation SLRWeekHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [UIColor lightGrayColor];

	_days = [NSMutableArray arrayWithCapacity:7];
	for (int i = 0; i < 7; i++)
	{
		SLRWeekDayView *dayView = [self newDayView];
		[dayView addTarget:self action:@checkselector(self, selectDay:) forControlEvents:UIControlEventTouchUpInside];
		[self.days addObject:dayView];
		[self.contentView addSubview:dayView];
		[dayView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.contentView);
			make.bottom.equalTo(self.contentView);
			if (i == 0)
			{
				make.leading.equalTo(self.contentView);

			}
			else
			{
				make.leading.equalTo(self.days[i - 1].mas_trailing);
				make.width.equalTo(self.days[0]);
			}
		}];
	}
	[self.days[6] mas_updateConstraints:^(MASConstraintMaker *make) {
		make.trailing.equalTo(self.contentView);
	}];

	return self;
}

- (void)selectDay:(SLRWeekDayView *)button
{
	[self.delegate weekHeaderView:self didSelectPage:button.page];
}

- (SLRWeekDayView *)newDayView
{
	SLRWeekDayView *dayView = [[SLRWeekDayView alloc] init];
	return dayView;
}

- (void)setWeekVM:(SLRWeekHeaderVM *)weekVM
{
	_weekVM = weekVM;
	[self.days enumerateObjectsUsingBlock:^(SLRWeekDayView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		obj.page = weekVM.pages[idx];
	}];
}

@end
