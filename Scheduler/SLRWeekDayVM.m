#import "SLRWeekDayVM.h"

@implementation SLRWeekDayVM

- (instancetype)initWithDate:(NSDate *)date
{
	self = [super init];
	if (self == nil) return nil;

	_date = date;
	_selected = NO;

	return self;
}

- (NSString *)title
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self.date];
	return [NSString stringWithFormat:@"%ld", components.day];
}

@end
