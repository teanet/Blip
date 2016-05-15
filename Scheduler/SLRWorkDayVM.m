#import "SLRWorkDayVM.h"

@interface SLRWorkDayVM ()

@property (nonatomic, strong, readonly) NSMutableArray<SLRIntervalVM *> *intervals;

@end

@implementation SLRWorkDayVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_intervals = [NSMutableArray array];
	_step = 15;
	_minInterval = 30;
	_length = 1440;
	return self;
}

- (void)insertInterval:(SLRIntervalVM *)intervalVM
{
	intervalVM.workDayVM = self;
	[self.intervals addObject:intervalVM];
	[self intervalDidEndDragging:intervalVM];
}

- (void)interval:(SLRIntervalVM *)intervalVM didChangeRange:(SLRRange *)range
{
	if (![self.intervals containsObject:intervalVM]) return;

	intervalVM.range = range;
}

- (SLRRange *)adjustRange:(SLRRange *)range
{
	NSInteger section = round((double)range.location / self.step);
	range.location = MAX(0, section * self.step);

	NSInteger ticks = round((double)range.length / self.step);
	range.length = ticks * self.step;

	if (range.end > self.length)
	{
		range.location = self.length - range.length;
	}

	return range;
}

- (void)interval:(SLRIntervalVM *)intervalVM didUpdateLocation:(NSInteger)location
{
	intervalVM.editing = YES;
	SLRRange *range = intervalVM.range;
	range.location = location;
	intervalVM.range = range;
}

- (void)intervalDidEndDragging:(SLRIntervalVM *)intervalVM
{
	SLRRange *adjustRange = [self adjustRange:intervalVM.range];
	__block BOOL intercect = NO;
	do
	{
		intercect = NO;
		[self.intervals enumerateObjectsUsingBlock:^(SLRIntervalVM *otherInterval, NSUInteger idx, BOOL * _Nonnull stop) {
			if (intervalVM != otherInterval)
			{
				if ([otherInterval.range intercectRange:adjustRange])
				{
					adjustRange.location = otherInterval.range.end;
					intercect = YES;
					*stop = YES;
				}
			}
		}];
	} while (intercect);

	intervalVM.range = adjustRange;
	intervalVM.editing = NO;
}

- (NSArray<SLRIntervalVM *> *)intervalsVMAtRange:(SLRRange *)range
{
	NSMutableArray *intervals = [NSMutableArray array];
	[self.intervals enumerateObjectsUsingBlock:^(SLRIntervalVM * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj.range intercectRange:range])
		{
			[intervals addObject:obj];
		}
	}];
	return [intervals copy];
}

- (NSArray<SLRIntervalVM *> *)intervalsVMAtMinute:(NSInteger)minute
{
	NSMutableArray *intervals = [NSMutableArray array];
	[self.intervals enumerateObjectsUsingBlock:^(SLRIntervalVM * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj.range containMinute:minute])
		{
			[intervals addObject:obj];
		}
	}];
	return [intervals copy];
}

@end
