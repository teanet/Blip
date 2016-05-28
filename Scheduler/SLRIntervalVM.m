#import "SLRIntervalVM.h"

@implementation SLRIntervalVM

+ (NSArray<SLRIntervalVM *> *)intervalsForRange:(SLRRange *)range step:(NSInteger)step
{
	NSMutableArray *intervals = [NSMutableArray array];
	for (NSInteger start = range.location; start < range.length + range.location; start += step)
	{
		SLRIntervalVM *intervalVM = [[SLRIntervalVM alloc] init];
		intervalVM.state = range.state;
		intervalVM.location = start;
		intervalVM.length = step;
		[intervals addObject:intervalVM];
	}
	return [intervals copy];
}

- (NSString *)timeString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterNoStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.location * 60.0]];
}

- (UIColor *)color
{
	switch (self.state) {
		case SLRRangeStateFree:
		{
			return [UIColor greenColor];
		}
		case SLRRangeStateHold:
		{
			return [UIColor grayColor];
		}
		case SLRRangeStateBook:
		{
			return [UIColor redColor];
		}
		case SLRRangeStateUndefined:
		{
			return [UIColor grayColor];
		}
	}
}

@end
