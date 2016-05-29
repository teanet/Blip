#import "SLRAuthenticationManager.h"

#import "SLRUser.h"
#import <DigitsKit/DigitsKit.h>


@implementation SLRAuthenticationManager

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
		DGTAuthenticationConfiguration *c = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:0];
		DGTAppearance *a = [[DGTAppearance alloc] init];
		a.backgroundColor = [UIColor whiteColor];
		a.accentColor = [UIColor dgs_colorWithString:@"1976D2"];
		a.logoImage = [UIImage imageNamed:@"logo"];
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
