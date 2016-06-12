#import "SLRWeekHeaderVM.h"

#import "SLRWeekDayVM.h"

static NSTimeInterval kSecondsInDay = 86400.0;

@implementation SLRWeekHeaderVM

- (instancetype)initWithStartDate:(NSDate *)startDate month:(NSInteger)month
{
	self = [super init];
	if (self == nil) return nil;

	[self createDayVMsWithStartDate:startDate month:month];

	return self;
}

- (void)createDayVMsWithStartDate:(NSDate *)startDate month:(NSInteger)month
{
	NSMutableArray<SLRWeekDayVM *> *dayVMs = [[NSMutableArray alloc] initWithCapacity:7];

	for (NSInteger i = 0; i < 7; i++)
	{
		NSDate *date = [startDate dateByAddingTimeInterval:i * kSecondsInDay];
		SLRWeekDayVM *dayVM = [[SLRWeekDayVM alloc] initWithDate:date];
		[dayVMs addObject:dayVM];
	}

	_dayVMs = [dayVMs copy];
}

- (void)didSelectDay:(SLRWeekDayVM *)selectedDayVM
{
}

@end
