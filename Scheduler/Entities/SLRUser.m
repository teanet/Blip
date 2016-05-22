#import "SLRUser.h"

static NSString *const kKeyId		= @"id";
static NSString *const kKeyFullName = @"full_name";
static NSString *const kKeyPhone	= @"phone";
static NSString *const kKeyToken	= @"token";

@implementation SLRUser

- (instancetype)initWithFullName:(NSString *)fullName
						   phone:(NSString *)phone
{
	self = [super init];
	if (self == nil) return nil;

	_fullName = [fullName copy];
	_phone = [phone copy];

	return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[kKeyId];
	_fullName = dictionary[kKeyFullName];
	_phone = dictionary[kKeyPhone];
	_token = dictionary[kKeyToken];

	return self;
}

- (NSDictionary *)dictionary
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

	[dictionary setValue:self.fullName forKey:kKeyFullName];
	[dictionary setValue:self.id forKey:kKeyId];
	[dictionary setValue:self.phone forKey:kKeyPhone];
	[dictionary setValue:self.token	forKey:kKeyToken];

	return [dictionary copy];
}

@end
