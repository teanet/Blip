#import "SLRAuthenticationManager.h"

#import "SLRUser.h"
#import "SLRDataProvider.h"
#import <DigitsKit/DigitsKit.h>
#import <SSKeychain.h>

static NSString *const kKeychainUserId			= @"userId";
static NSString *const kKeychainPhone			= @"phone";
static NSString *const kKeychainAuthToken		= @"authToken";
static NSString *const kKeychainAuthTokenSecret = @"authTokenSecret";

@interface SLRAuthenticationManager ()

@property (nonatomic, strong, readwrite) SLRUser *user;

@end

@implementation SLRAuthenticationManager

+ (NSString *)appName
{
	return [NSBundle bundleForClass:self.class].infoDictionary[@"CFBundleName"];
}

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;
	
	_user = [self retrievedUserFromKeychain];

	return self;
}

- (SLRUser *)retreivedUser
{
	SLRUser *user = nil;

	user = [self retrievedUserFromKeychain];

	if (!user)
	{
		user = [self retrievedUserFromSession];
		[self setUserToKeychain:user];
	}

	return user;
}

- (SLRUser *)retrievedUserFromSession
{
	DGTSession *session = [Digits sharedInstance].session;
	return [self userWithSession:session];
}

- (SLRUser *)userWithSession:(DGTSession *)session
{
	SLRUser *user = nil;

	if (session)
	{
		user = [[SLRUser alloc] initWithUserId:session.userID
									 authToken:session.authToken
							   authTokenSecret:session.authTokenSecret
										 phone:session.phoneNumber];
	}

	return user;
}


- (SLRUser *)retrievedUserFromKeychain
{
	SLRUser *user = nil;

//	NSString *appName = [self.class appName];
//
//	NSString *retreivedUserId = [SSKeychain passwordForService:appName account:kKeychainUserId];
//	NSString *retreivedPhone = [SSKeychain passwordForService:appName account:kKeychainPhone];
//	NSString *retreivedAuthToken = [SSKeychain passwordForService:appName account:kKeychainAuthToken];
//	NSString *retreivedAuthTokenSecret = [SSKeychain passwordForService:appName account:kKeychainAuthTokenSecret];
//
//	if (retreivedPhone.length > 0 &&
//		retreivedUserId.length > 0 &&
//		retreivedAuthToken.length > 0 &&
//		retreivedAuthTokenSecret.length > 0)
//	{
//		user = [[SLRUser alloc] initWithUserId:retreivedUserId
//									 authToken:retreivedAuthToken
//							   authTokenSecret:retreivedAuthTokenSecret
//										 phone:retreivedPhone];
//	}

	return user;
}

- (void)setUserToKeychain:(SLRUser *)user
{
	if (!user) return;

	NSString *appName = [self.class appName];

	if (user.userId.length > 0 &&
		user.phone.length > 0 &&
		user.authToken.length > 0 &&
		user.authTokenSecret.length > 0)
	{
		[SSKeychain setPassword:user.userId forService:appName account:kKeychainUserId];
		[SSKeychain setPassword:user.phone forService:appName account:kKeychainPhone];
		[SSKeychain setPassword:user.authToken forService:appName account:kKeychainAuthToken];
		[SSKeychain setPassword:user.authTokenSecret forService:appName account:kKeychainAuthTokenSecret];
	}
}

- (RACSignal *)fetchAuthenticatedUser
{
	return self.user
		? /*[self authenticateUserBySMSSignal]//*/[RACSignal return:self.user]
		: [self authenticateUserBySMSSignal];
}

- (RACSignal *)authenticateUserBySMSSignal
{
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		DGTAuthenticationConfiguration *c = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:0];
		DGTAppearance *a = [[DGTAppearance alloc] init];
		a.backgroundColor = [UIColor whiteColor];
		a.accentColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarBGColor;
		a.logoImage = [SLRDataProvider sharedProvider].projectSettings.logoImage;
		c.appearance = a;
		[[Digits sharedInstance] authenticateWithViewController:nil
												  configuration:c
													 completion:^(DGTSession *session, NSError *error) {
														if (error)
														{
															[subscriber sendError:error];
														}
														else
														{
															SLRUser *user = [self userWithSession:session];
															self.user = user;
															[self setUserToKeychain:user];
															[subscriber sendNext:user];
															[subscriber sendCompleted];
														}
													}];

		return nil;
	}];
}

@end
