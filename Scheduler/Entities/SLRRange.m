#import "SLRRange.h"

#import "SLRIntervalVM.h"

@interface SLRRange ()

@property (nonatomic, assign, readwrite) NSInteger location;
@property (nonatomic, assign, readwrite) NSInteger length;
@property (nonatomic, assign, readwrite) SLRRangeState state;

@end

@implementation SLRRange

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];

	NSDictionary *userDictionary = dictionary[@"user"];
	if ([userDictionary isKindOfClass:[NSDictionary class]])
	{
		_user = [[SLRUser alloc] initWithDictionary:userDictionary];
	}

	_location = [dictionary[@"location"] integerValue];
	_length = [dictionary[@"length"] integerValue];
	_summary = dictionary[@"summary"];

	_state = SLRRangeStateUndefined;
	NSString *stateString = dictionary[@"state"];

	if ([[stateString lowercaseString] isEqualToString:@"free"])
	{
		_state = SLRRangeStateFree;
	}
	else if ([[stateString lowercaseString] isEqualToString:@"hold"])
	{
		_state = SLRRangeStateHold;
	}
	else if ([[stateString lowercaseString] isEqualToString:@"book"])
	{
		_state = SLRRangeStateBook;
	}

	NSArray <NSDictionary *> *serviceDictionaries = dictionary[@"services"];
	if ([serviceDictionaries isKindOfClass:[NSArray class]])
	{
		_services = [[serviceDictionaries rac_sequence]
			map:^SLRService *(NSDictionary *serviceDictionary) {
				return [[SLRService alloc] initWithDictionary:serviceDictionary];
			}].array;
	}

	return self;
}

+ (instancetype)rangeWithInterval:(SLRIntervalVM *)intervalVM bookingTime:(NSTimeInterval)bookingTime
{
	SLRRange *range = [[SLRRange alloc] initWithDictionary:@{}];
	range.location = intervalVM.location;
	range.length = bookingTime;
	range.state = SLRRangeStateHold;
	return range;
}

@end
