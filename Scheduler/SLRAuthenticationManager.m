#import "SLRAuthenticationManager.h"

#import "SLRUser.h"
#import <DigitsKit/DigitsKit.h>
#import <SSKeychain.h>

@implementation SLRAuthenticationManager

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	return self;
}

- (RACSignal *)fetchUser
{
	SLRUser *authenticatedUser = [self userWithSession:[Digits sharedInstance].session];
	return authenticatedUser
		? [RACSignal return:authenticatedUser]
		: [self authenticateUserBySMSSignal];
}

- (RACSignal *)authenticateUserBySMSSignal
{
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[[Digits sharedInstance] authenticateWithCompletion:^(DGTSession *session, NSError *error) {
			if (error)
			{
				[subscriber sendError:error];
			}
			else
			{
				[subscriber sendNext:[self userWithSession:session]];
				[subscriber sendCompleted];
			}
		}];
		
		return nil;
	}];
}

- (SLRUser *)userWithSession:(DGTSession *)session
{
	if (!session) return nil;

	SLRUser *user = [[SLRUser alloc] initWithUserId:session.userID
										  authToken:session.authToken
									authTokenSecret:session.authTokenSecret
											  phone:session.phoneNumber];
	return user;
}

@end
