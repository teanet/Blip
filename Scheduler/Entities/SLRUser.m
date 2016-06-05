#import "SLRUser.h"

static NSString *const kKeyId				= @"user_id";
static NSString *const kKeyPhone			= @"phone";
static NSString *const kKeyAuthToken		= @"auth_token";
static NSString *const kKeyAuthTokenSecret	= @"auth_token_secret";

@implementation SLRUser

- (instancetype)initWithUserId:(NSString *)userId
					 authToken:(NSString *)authToken
			   authTokenSecret:(NSString *)authTokenSecret
						 phone:(NSString *)phone
{
	self = [super init];
	if (self == nil) return nil;

	_userId = [userId copy];
	_phone = [phone copy];
	_authToken = [authToken copy];
	_authTokenSecret = [authTokenSecret copy];

	return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_userId = dictionary[kKeyId];
	_phone = dictionary[kKeyPhone];
	_authToken = dictionary[kKeyAuthToken];
	_authTokenSecret = dictionary[kKeyAuthTokenSecret];

	return self;
}

- (NSDictionary *)dictionary
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

//	[dictionary setValue:self.fullName forKey:kKeyFullName];
	[dictionary setValue:self.userId forKey:kKeyId];
	[dictionary setValue:self.phone forKey:kKeyPhone];
	[dictionary setValue:self.authToken	forKey:kKeyAuthToken];
	[dictionary setValue:self.authTokenSecret forKey:kKeyAuthTokenSecret];

	return [dictionary copy];
}

@end
