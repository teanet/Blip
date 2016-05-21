#import "SLRUser.h"

@implementation SLRUser

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_fullName = dictionary[@"full_name"];
	_phone = dictionary[@"phone"];

	return self;
}

@end
