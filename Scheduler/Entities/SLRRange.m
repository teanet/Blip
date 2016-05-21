#import "SLRRange.h"

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

	if ([stateString isEqualToString:@"free"])
	{
		_state = SLRRangeStateFree;
	}
	else if ([stateString isEqualToString:@"hold"])
	{
		_state = SLRRangeStateHold;
	}
	else if ([stateString isEqualToString:@"book"])
	{
		_state = SLRRangeStateBook;
	}

	return self;
}

@end