#import "SLRIntervalVM.h"

#import "UIColor+DGSCustomColor.h"

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
			return [UIColor dgs_colorWithString:@"FBFAF9"];
		}
		case SLRRangeStateHold:
		{
			return [UIColor dgs_colorWithString:@"F3F0EC"];
		}
		case SLRRangeStateBook:
		{
			return [UIColor dgs_colorWithString:@"F3F0EC"];
		}
		case SLRRangeStateUndefined:
		{
			return [UIColor grayColor];
		}
	}
}

@end
