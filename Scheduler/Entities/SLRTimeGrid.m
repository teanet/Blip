#import "SLRTimeGrid.h"

@implementation SLRTimeGrid

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_bookingStep = [dictionary[@"booking_step"] integerValue];
	_bookingIntervalMin = [dictionary[@"booking_interval_min"] integerValue];
	_bookingIntervalMax = [dictionary[@"booking_interval_max"] integerValue];

	return self;
}

@end
