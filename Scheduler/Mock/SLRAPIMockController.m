#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRPurpose.h"
#import "SLRService.h"
#import "SLRStoreItem.h"
#import "SLRRequest.h"

#import <AFNetworking/AFNetworking.h>
#import "SLRAPIMockController.h"

static NSString *const kSLRVKAPIBaseURLString = @"https://api.vk.com/method/";
static NSString *const kSLRVKGroupId = @"-65095687";//@"-19638468";
static NSString *const kSLRVKAlbumId = @"227906560";//@"177366013";

@interface SLRAPIMockController ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation SLRAPIMockController

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kSLRVKAPIBaseURLString]];
	_requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
	_requestManager.requestSerializer.timeoutInterval = 10.0;
	_requestManager.responseSerializer = [AFJSONResponseSerializer serializer];

	return self;
}

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials
{
	return [RACSignal return:@[[SLRFilial testFilial]]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPurposesForFilial:(SLRFilial *)filial
{
	return [RACSignal return:[SLRPurpose testPurposes]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
{
	return [RACSignal return:@[[SLRPage testPage]]];
}

- (RACSignal *)fetchOwnersForFilial:(SLRFilial *)filial
{
	return [RACSignal return:@[
		[SLROwner testOwnerDoctorOne],
		[SLROwner testOwnerDoctorTwo],
		[SLROwner testOwnerDoctorThree]
	]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date
{
	return [RACSignal return:@[[SLRPage testPage]]];
}

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range
{
	return [RACSignal return:[SLRService testServices]];
}

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return SLRRequest
 **/
- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request
{
	return [RACSignal return:[SLRRequest testRequestReviewed]];
}

- (RACSignal *)fetchRequestsForUser:(SLRUser *)user
{
	return [RACSignal return:@[[SLRRequest testRequestReviewed]]];
}

//api.vk.com/method/photos.get?owner_id=&album_id=&rev=&extended=1&photo_sizes=0&v=5.52
- (RACSignal *)fetchStoreItems
{
	NSDictionary *params = @{
							 @"owner_id": kSLRVKGroupId,
							 @"album_id" : kSLRVKAlbumId,
							 @"rev" : @"1",
							 @"extended" : @"1",
							 @"photo_sizes" : @"0",
							 @"v" : @"5.52",
							 };

	return [[self GET:@"photos.get" params:params]
			map:^NSArray <SLRStoreItem *> *(NSDictionary *responseObject) {
				NSArray <SLRStoreItem *> *returnArray = nil;

				if ([responseObject isKindOfClass:[NSDictionary class]])
				{
					NSDictionary *resultDictionary = responseObject[@"response"];
					NSArray<NSDictionary *> *itemDictionaries = resultDictionary[@"items"];

					returnArray = [itemDictionaries.rac_sequence
						map:^SLRStoreItem *(NSDictionary *itemDictionary) {
							return [[SLRStoreItem alloc] initWithDictionary:itemDictionary];
						}].array;
				}
				
				return returnArray;
			}];
}

// MARK: Private
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

@end
