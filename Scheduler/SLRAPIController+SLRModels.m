#import "SLRAPIController+SLRModels.h"

#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRService.h"
#import "SLRRequest.h"
#import "SLRFilial.h"
#import "SLRUser.h"

@implementation SLRAPIController (TKSModels)

- (RACSignal *)fetchFilials
{
	NSString *methodName = [NSString stringWithFormat:@"/api/1.0/project/%@/info", self.applicationKey];
	return [[self GET:methodName params:nil]
		map:^NSArray<SLRFilial *> *(NSDictionary *responseDictionary) {
			NSArray<NSDictionary *> *filialDictionaies = responseDictionary[@"branches"];

			NSDictionary *settingsDictionary = responseDictionary[@"settings"];
			SLRProjectSettings *projectSettings = [[SLRProjectSettings alloc] initWithDictionary:settingsDictionary];
			self.projectSettings = projectSettings;

			return [filialDictionaies.rac_sequence map:^SLRFilial *(NSDictionary *filialDictionary) {
				return [[SLRFilial alloc] initWithDictionary:filialDictionary];
			}].array;
		}];
}

- (RACSignal *)fetchPageForOwner:(SLROwner *)owner date:(NSDate *)date
{
	NSString *methodName = [NSString stringWithFormat:@"/api/1.0/project/%@/schedule", self.applicationKey];
	NSString *dateString = [[SLRAPIController dateFormatter] stringFromDate:date];

	NSDictionary *params = @{
			@"date" : dateString,
			@"master_id" : owner.id
		};

	return [[self GET:methodName params:params]
		map:^SLRPage *(NSDictionary *responseDictionary) {
			return [[SLRPage alloc] initWithDictionary:responseDictionary];
		}];
}

- (RACSignal *)fetchRegisteredUserForUser:(SLRUser *)user
{
	NSString *methodName = @"/api/1.0/user/register";
	NSDictionary *params = user.dictionary;

	return [[self POST:methodName params:params]
		flattenMap:^RACStream *(id value) {
			return [RACSignal return:user];
		}];
}

- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request user:(SLRUser *)user
{
#warning >>> HERE
//	NSString *methodName = [NSString stringWithFormat:@"/api/1.0/project/%@/schedule/book", self.applicationKey];
//	NSDictionary *params = @{
//		@"date" : [[self.class dateFormatter] stringFromDate:request.date],
//		@"location" : [NSString stringWithFormat:@"%ld", request.location],
//		@"length" : @"30",//[NSString stringWithFormat:@"%ld", request.length],
//		@"page_id" : request.page.id,
//		@"user_id" : user.userId
//	};

	NSString *dateString = [[self.class dateFormatter] stringFromDate:request.date];
	NSString *locString = [NSString stringWithFormat:@"%ld", request.location];
	NSString *lenString = @"30";
	NSString *methodName =
	[NSString stringWithFormat:@"/api/1.0/project/%@/schedule/book?date=%@&location=%@&length=%@&page_id=%@&user_id=%@",
	 self.applicationKey, dateString, locString, lenString, request.page.id, user.userId];

	return [self POST:methodName params:nil];
}



+ (NSDateFormatter *)dateFormatter
{
	static dispatch_once_t onceToken;
	static NSDateFormatter *dateFormatter;
	dispatch_once(&onceToken, ^{
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
		[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	});

	return dateFormatter;
}

//- (RACSignal *)fetchSuggestsForSearchString:(NSString *)searchString
//								   regionId:(NSString *)regionId
//{
//	NSCParameterAssert(regionId);
//
//	if ((searchString.length == 0) || (regionId.length == 0)) return [RACSignal return:nil];
//
//	NSDictionary *params = @{
//							 @"key": self.webAPIKey,
//							 @"type": @"default",//@"street",
//							 @"region_id" : regionId,
//							 @"lang" : @"ru",
//							 @"output" : @"json",
//							 @"types" : @"adm_div.settlement,adm_div.city,address,street,branch",
//							 @"q": searchString,
//							 };
//
//	return [[self GET:@"suggest/list" service:TKSServiceWebAPI params:params]
//			map:^NSArray<TKSSuggest *> *(NSDictionary *responseObject) {
//				NSArray<TKSSuggest *> *returnArray = nil;
//
//				if ([responseObject isKindOfClass:[NSDictionary class]])
//				{
//					NSDictionary *resultDictionary = responseObject[@"result"];
//					NSArray *hintDictionaries = resultDictionary[@"items"];
//					returnArray = [hintDictionaries.rac_sequence
//
//								   map:^TKSSuggest *(NSDictionary *hintDictionary) {
//									   return [[TKSSuggest alloc] initWithDictionary:hintDictionary];
//								   }].array;
//				}
//				
//				return returnArray;
//			}];
//}

@end
