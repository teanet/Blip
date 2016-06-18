#import "SLRAPIController+SLRModels.h"

#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRService.h"

#import "SLRFilial.h"

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
