#import "SLRDataProvider.h"

#import "SLRAPIController+SLRModels.h"

static NSString *const kSLRShedulerAPIKey = @"ruczoy1743";
static NSString *const kSLRShedulerApplicationKey = @"1234567890";
static NSString *const kSLRShedulerUserId = @"0987654321";

@interface SLRDataProvider ()

@property (nonatomic, strong, readonly) SLRAPIController *apiController;

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

	_apiController = [[SLRAPIController alloc] initWithSchedulerAPIKey:kSLRShedulerAPIKey
														applicationKey:kSLRShedulerApplicationKey
																userId:kSLRShedulerUserId];
	return self;
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

@end
