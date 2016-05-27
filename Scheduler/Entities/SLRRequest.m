#import "SLRRequest.h"

@interface SLRRequest ()

@property (nonatomic, copy, readonly, nullable) NSString *id;
@property (nonatomic, strong, readonly) SLRUser *user;
@property (nonatomic, assign, readonly) SLRRequestState state;
@property (nonatomic, copy, readonly) NSString *stateReason;

@end

@implementation SLRRequest

- (instancetype)initWithUser:(SLRUser *)user
{
	self = [super init];
	if (self == nil) return nil;

	_user = user;
	_state = SLRRequestStateUndefined;

	return self;
}

@end

@implementation SLRRequest (SLRTesting)

+ (SLRRequest *)testRequestReviewed
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"requestReviewed.json" ofType:nil]];
	NSDictionary *testDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	return [[SLRRequest alloc] initWithDictionary:testDictionary];
}

@end

