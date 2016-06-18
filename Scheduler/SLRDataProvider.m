#import "SLRDataProvider.h"

#import "SLRAPIController+SLRModels.h"
#import "SLRAPIMockController.h"
#import "SLRAuthenticationManager.h"

//#define USE_MOCK_CONTROLLER

static NSString *const kSLRShedulerAPIKey = @"shedulerAPIKey";
static NSString *const kSLRShedulerApplicationKey = @"1";

@interface SLRDataProvider ()

@property (nonatomic, strong, readonly) id<SLRAPIControllerProtocol> apiController;
@property (nonatomic, strong, readonly) SLRAuthenticationManager *authManager;
@property (nonatomic, strong, readonly) NSMutableArray<SLRStoreItem *> *storeItems;

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

	_storeItems = [NSMutableArray array];
	_authManager = [[SLRAuthenticationManager alloc] init];

#ifdef USE_MOCK_CONTROLLER
	_apiController = [[SLRAPIMockController alloc] init];
#else
	_apiController = [[SLRAPIController alloc] initWithSchedulerAPIKey:kSLRShedulerAPIKey
														applicationKey:kSLRShedulerApplicationKey];
#endif

	return self;
}

@end


// MARK: Authenticate API

@implementation SLRDataProvider (Authenticate)

- (SLRProjectSettings *)projectSettings
{
	return self.apiController.projectSettings;
}

- (SLRUser *)user
{
	return self.authManager.user;
}

- (RACSignal *)fetchAuthenticatedUser
{
#warning >>> HERE
	if (self.user)
	{
		return [self.authManager fetchAuthenticatedUser];
	}
	else
	{
		return [[self.authManager fetchAuthenticatedUser]
			flattenMap:^RACStream *(SLRUser *user) {
				return [self fetchRegisteredUserForUser:user];
			}];
	}
}

@end

@implementation SLRDataProvider (CreateEntities)

- (RACSignal *)fetchEmptyBookingRequestForPage:(SLRPage *)page
{
	return [[self fetchAuthenticatedUser]
		map:^SLRRequest *(SLRUser *user) {
			return [self emptyBookingRequestForUser:user page:page];
		}];
}

- (SLRRequest *)emptyBookingRequestForUser:(SLRUser *)user page:(SLRPage *)page
{
	NSCAssert(user, @"User should be set before using booking method.");
	if (!user) return nil;

	return [[SLRRequest alloc] initWithUser:user page:page];
}

@end


// MARK: Scheduler API

@implementation SLRDataProvider (SchedulerService)

- (RACSignal *)fetchRegisteredUserForUser:(SLRUser *)user;
{
	return [self.apiController fetchRegisteredUserForUser:user];
}

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials
{
	return [self.apiController fetchFilials];
}

- (RACSignal *)fetchPageForOwner:(SLROwner *)owner date:(NSDate *)date
{
	return [self.apiController fetchPageForOwner:owner date:date];
}





/*! \return @[SLRPurpose] */
- (RACSignal *)fetchPurposesForFilial:(SLRFilial *)filial
{
	return nil;
}

/*! \return @[SLROwner] */
- (RACSignal *)fetchOwnersForFilial:(SLRFilial *)filial
{
	return [self.apiController fetchOwnersForFilial:filial];
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
	return [self.apiController fetchPageForOwner:owner date:date];
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

- (RACSignal *)fetchRequests
{
	return [[self.authManager fetchAuthenticatedUser]
			flattenMap:^RACStream *(SLRUser *user) {
				return [self.apiController fetchRequestsForUser:user];
			}];
}

@end


// MARK: Store API

@implementation SLRDataProvider (StoreService)

- (RACSignal *)fetchStoreItems
{
	return [self.apiController fetchStoreItems];
}

- (void)addStoreItemToCart:(SLRStoreItem *)storeItem
{
	if (storeItem)
	{
		@synchronized (self)
		{
			[self.storeItems addObject:storeItem];
		}
	}
}

- (void)removeStoreItemFromCart:(SLRStoreItem *)storeItem
{
	if (storeItem)
	{
		@synchronized (self)
		{
			[self.storeItems removeObject:storeItem];
		}
	}
}

- (NSArray<SLRStoreItem *> *)cartStoreItems
{
	return [self.storeItems copy];
}

@end
