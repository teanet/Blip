#import "SLRWeekDayVM.h"

@implementation SLRWeekDayVM

- (instancetype)initWithDate:(NSDate *)date month:(NSInteger)month
{
	self = [super init];
	if (self == nil) return nil;

	_date = date;
	_month = month;
	_selected = NO;

	return self;
}

- (NSString *)title
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self.date];
	return [NSString stringWithFormat:@"%ld", components.day];
}

- (BOOL)interactive
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self.date];
	return components.month == self.month;
}

@end
