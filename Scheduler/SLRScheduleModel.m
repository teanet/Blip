#import "SLRScheduleModel.h"

#import "SLRFreeInterval.h"

@implementation SLRScheduleModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_canAdjustInterval = [dictionary[@"canAdjustInterval"] boolValue];
	_step = [dictionary[@"step"] integerValue];
	NSDictionary *range = dictionary[@"availableRange"];
	_availableRange = NSMakeRange([range[@"location"] integerValue], [range[@"length"] integerValue]);
	_scheduleIntervals = nil;

	return self;
}

- (NSArray<id<SLRScheduleInterval>> *)allIntervals
{
	NSInteger cellCount = self.availableRange.length / self.step;
	NSMutableIndexSet *availableIndexes = [NSMutableIndexSet indexSetWithIndexesInRange:self.availableRange];

	[self.scheduleIntervals enumerateObjectsUsingBlock:^(id<SLRScheduleInterval> interval, NSUInteger idx, BOOL * _Nonnull stop) {
		[availableIndexes removeIndexesInRange:interval.range];
	}];

	NSMutableArray *availableIntervals = [NSMutableArray arrayWithCapacity:cellCount];
	for (int i = 0; i < cellCount; i++)
	{
		NSRange range = NSMakeRange(i * self.step, self.step);
		if ([availableIndexes containsIndexesInRange:range])
		{
			SLRFreeInterval *freeInterval = [[SLRFreeInterval alloc] initWithRange:range];
			[availableIntervals addObject:freeInterval];
		}
	}

	[availableIntervals addObjectsFromArray:self.scheduleIntervals];

	return availableIntervals;
}

- (BOOL)canBookInterval:(id<SLRScheduleInterval>)interval
{
	return NO;
}

- (BOOL)bookInterval:(id<SLRScheduleInterval>)interval
{
	return NO;
}

@end
