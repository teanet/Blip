#import "SLRRequest.h"

@interface SLRRequest ()

@property (nonatomic, copy, readonly, nullable) NSString *id;
@property (nonatomic, strong, readonly) SLRUser *user;
@property (nonatomic, assign, readonly) SLRRequestState state;
@property (nonatomic, copy, readonly) NSString *stateReason;

@end

@implementation SLRRequest

- (instancetype)initWithUser:(SLRUser *)user page:(SLRPage *)page
{
	self = [super init];
	if (self == nil) return nil;

	_user = user;
	_page = page;
	_state = SLRRequestStateUndefined;
	_date = page.date;

	return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];

	NSDictionary *pageDictionary = dictionary[@"page"];
	if ([pageDictionary isKindOfClass:[NSDictionary class]])
	{
		_page = [[SLRPage alloc] initWithDictionary:pageDictionary];
	}

	NSDictionary *userDictionary = dictionary[@"user"];
	if ([userDictionary isKindOfClass:[NSDictionary class]])
	{
		_user = [[SLRUser alloc] initWithDictionary:userDictionary];
	}

	_location = [dictionary[@"location"] integerValue];
	_length = [dictionary[@"length"] integerValue];
	_summary = dictionary[@"summary"];

	_state = SLRRequestStateUndefined;
	NSString *stateString = dictionary[@"state"];

	if ([[stateString lowercaseString] isEqualToString:@"review"])
	{
		_state = SLRRequestStateReview;
	}
	else if ([[stateString lowercaseString] isEqualToString:@"book"])
	{
		_state = SLRRequestStateApprove;
	}
	else if ([[stateString lowercaseString] isEqualToString:@"reject"])
	{
		_state = SLRRequestStateReject;
	}

	_stateReason = dictionary[@"state_reason"];

	NSArray <NSDictionary *> *serviceDictionaries = dictionary[@"services"];
	if ([serviceDictionaries isKindOfClass:[NSArray class]])
	{
		_services = [[serviceDictionaries rac_sequence]
			map:^SLRService *(NSDictionary *serviceDictionary) {
				return [[SLRService alloc] initWithDictionary:serviceDictionary];
			}].array;
	}

	// ------- Hackathon -------
	_dateString = dictionary[@"date"];

	NSDictionary *addressDictionary = dictionary[@"address"];
	_address = addressDictionary[@"name"];

	NSDictionary *masterDictionary = dictionary[@"master"];
	_masterImageURLString = masterDictionary[@"image"];
	_masterTitle = masterDictionary[@"title"];

	NSDictionary *serviceDictionary = dictionary[@"service"];
	_serviceTitle = serviceDictionary[@"title"];

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

