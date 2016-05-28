#import "SLRDataProvider.h"

#import "SLRAPIController+SLRModels.h"
#import "SLRAPIMockController.h"
#import "SLRAuthenticationManager.h"

#define USE_MOCK_CONTROLLER

static NSString *const kSLRShedulerAPIKey = @"ruczoy1743";
static NSString *const kSLRShedulerApplicationKey = @"1234567890";
static NSString *const kSLRShedulerUserId = @"0987654321";

@interface SLRDataProvider ()

@property (nonatomic, strong, readonly) id<SLRAPIControllerProtocol> apiController;
@property (nonatomic, strong, readonly) SLRAuthenticationManager *authManager;

@end

@implementation SLRDataProvider

+ (instancetype)sharedProvider
{
	static SLRDataProvider *provider = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		provider = [[SLRDataProvider alloc] init];
	});

	return provider;
}

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_authManager = [[SLRAuthenticationManager alloc] init];

#ifdef USE_MOCK_CONTROLLER
	_apiController = [[SLRAPIMockController alloc] init];
#else
	_apiController = [[SLRAPIController alloc] initWithSchedulerAPIKey:kSLRShedulerAPIKey
														applicationKey:kSLRShedulerApplicationKey];
#endif

	return self;
}

// MARK: Misc

- (RACSignal *)fetchEmptyBookingRequest
{
	return [[self.authManager fetchUser]
		map:^SLRRequest *(SLRUser *user) {
			return [self emptyBookingRequestForUser:user];
		}];
}

- (SLRRequest *)emptyBookingRequestForUser:(SLRUser *)user
{
	NSCAssert(user, @"User should be set before using booking method.");
	if (!user) return nil;

	return [[SLRRequest alloc] initWithUser:user];
}

// MARK: API

- (RACSignal *)fetchRegisteredUserForUser:(SLRUser *)user;
{
	return [self.apiController fetchRegisteredUserForUser:user];
}

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials
{
	return [self.apiController fetchFilials];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
{
	return [self.apiController fetchPagesForOwner:owner];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date
{
	return [self.apiController fetchPagesForOwner:owner date:date];
}

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range
{
	return [self.apiController fetchServicesForPage:page range:range];
}

- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request
{
	return [self.apiController fetchProcessedRequestForRequest:request];
}

@end
