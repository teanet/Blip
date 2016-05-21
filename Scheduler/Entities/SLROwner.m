#import "SLROwner.h"

@implementation SLROwner

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_title = dictionary[@"title"];

	return self;
}

@end
