#import "SLRAPIController.h"

#import "SLRProjectSettings.h"
#import <AFNetworking/AFNetworking.h>
#import <UIDevice-Hardware.h>

#define CURRENT_VERSION ([[NSBundle bundleForClass:self.class] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])
#define CURRENT_BUILD ([[NSBundle bundleForClass:self.class] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey])

static NSString *const kSLRSchedulerAPIBaseURLString = @"http://api.shtab.yanke.ru";

@interface SLRAPIController ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
@property (nonatomic, strong, readwrite) SLRProjectSettings *projectSettings;

@end

@implementation SLRAPIController

- (instancetype)initWithSchedulerAPIKey:(NSString *)schedulerAPIKey
						 applicationKey:(NSString *)applicationKey
{
	self = [super init];
	if (self == nil) return nil;

	NSCAssert(schedulerAPIKey.length > 0, @"You should add API token for correct work with Scheduler API.");
	NSCAssert(applicationKey.length > 0, @"You should add Application Key for correct work with Scheduler API.");

	_schedulerAPIKey = [schedulerAPIKey copy];
	_applicationKey = [applicationKey copy];
	_requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kSLRSchedulerAPIBaseURLString]];

	_requestManager.requestSerializer = [AFJSONRequestSerializer serializer];

	NSDictionary *headers = @{
		@"X-Current-App-Build" : CURRENT_BUILD,
		@"X-Current-App-Version" : CURRENT_VERSION,
		@"X-Mobile-Vendor" : @"Apple",
		@"X-Mobile-Platform" : @"iOS",
		@"X-Mobile-Os-Version" : [[UIDevice currentDevice] systemVersion],
		@"X-Mobile-Model": [[UIDevice currentDevice] modelName],
		@"X-API-Token": schedulerAPIKey,
		@"X-Application-Key": schedulerAPIKey,
	};
	[headers enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		[_requestManager.requestSerializer setValue:value forHTTPHeaderField:key];
	}];

	_requestManager.requestSerializer.timeoutInterval = 10.0;
	_requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
	NSSet *typesSet = [NSSet setWithArray:@[@"text/plain", @"application/json"]];
	[_requestManager.responseSerializer setAcceptableContentTypes:typesSet];

	return self;
}

- (RACSignal *)GET:(NSString *)method params:(NSDictionary *)params
{
	@weakify(self);
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		@strongify(self);

		id successBlock = ^(AFHTTPRequestOperation *operation, id responseObject) {
			NSLog(@"<SLRAPIController> Request did successfully complete: %@", operation.request);

			[subscriber sendNext:responseObject];
			[subscriber sendCompleted];
		};

		id failBlock = ^(AFHTTPRequestOperation *operation, NSError *error) {
			NSLog(@"<SLRAPIController> REQUEST ERROR: %@", error);
			[subscriber sendError:error];
		};

		AFHTTPRequestOperation *operation = [self.requestManager GET:method parameters:params success:successBlock failure:failBlock];

		return [RACDisposable disposableWithBlock:^{
			[operation cancel];
		}];
	}];
}

- (RACSignal *)POST:(NSString *)method params:(NSDictionary *)params
{
	@weakify(self);
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		@strongify(self);

		id successBlock = ^(AFHTTPRequestOperation *operation, id responseObject) {
			NSLog(@"<SLRAPIController> Request did successfully complete: %@", operation.request);

			[subscriber sendNext:responseObject];
			[subscriber sendCompleted];
		};

		id failBlock = ^(AFHTTPRequestOperation *operation, NSError *error) {
			NSLog(@"<SLRAPIController> REQUEST ERROR: %@", error);
			[subscriber sendError:error];
		};

		AFHTTPRequestOperation *operation = [self.requestManager POST:method parameters:params success:successBlock failure:failBlock];

		return [RACDisposable disposableWithBlock:^{
			[operation cancel];
		}];
	}];
}

@end
