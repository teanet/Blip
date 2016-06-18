#import "SLRPurpose.h"

@implementation SLRPurpose

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_title = dictionary[@"title"];
	_imageURLString = dictionary[@"image"];
	_subtitle = dictionary[@"subtitle"];
	_summary = dictionary[@"summary"];
	_price = [dictionary[@"price"] integerValue];
	_pricePerTimeUnit = [dictionary[@"price_per_time_unit"] integerValue];
	_timeUnit = [dictionary[@"time_unit"] integerValue];
	_canMultipleSelect = [dictionary[@"can_multiple_select"] boolValue];
	_bookingIntervalMin = [dictionary[@"min_length"] integerValue];
	_bookingIntervalMax = [dictionary[@"max_length"] integerValue];

	return self;
}

@end

@implementation SLRPurpose (SLRTesting)

+ (NSArray <SLRPurpose *> *)testPurposes
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"purposes.json" ofType:nil]];
	NSArray *testArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	return [testArray.rac_sequence
			map:^SLRPurpose *(NSDictionary *dictionary) {
				return [[SLRPurpose alloc] initWithDictionary:dictionary];
			}].array;
}

@end
