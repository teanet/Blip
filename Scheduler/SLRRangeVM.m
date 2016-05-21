NSInteger const kSLRMinimumLength = 30;

#import "SLRRangeVM.h"

@implementation SLRRangeVM

- (void)setLength:(NSInteger)length
{
	_length = MAX(kSLRMinimumLength, length);
}

- (NSInteger)end
{
	return self.location + self.length;
}

- (void)dragUp:(NSInteger)delta
{
	self.location += delta;
	self.length -= delta;
}

- (void)dragDown:(NSInteger)delta
{
	self.length += delta;
}

- (BOOL)intercectRange:(SLRRangeVM *)range
{
	return !(self.end <= range.location || range.end <= self.location);
}

- (BOOL)containMinute:(NSInteger)minute
{
	return (minute > self.location) && (minute < self.end);
}

@end
