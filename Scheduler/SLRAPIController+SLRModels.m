#import "SLRAPIController+SLRModels.h"

#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRService.h"
#import "SLRRequest.h"
#import "SLRFilial.h"
#import "SLRUser.h"
#import "SLRNews.h"

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

// sendNext @[SLRNews]
- (RACSignal *)fetchNews
{
	NSString *methodName = [NSString stringWithFormat:@"/api/1.0/project/%@/news", self.applicationKey];

	return [[self GET:methodName params:nil]
		map:^NSArray<SLRNews *> *(NSDictionary *responseDictionary) {
			NSArray<NSDictionary *> *newsArray = responseDictionary[@"news"];
			return [newsArray.rac_sequence map:^SLRNews *(NSDictionary *newsDictionary) {
						return [[SLRNews alloc] initWithDictionary:newsDictionary];
					}].array;
		}];
}

- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request user:(SLRUser *)user
{
	NSString *dateString = [[self.class dateFormatter] stringFromDate:request.date];
	NSString *locString = [NSString stringWithFormat:@"%ld", (long)request.location];
	NSString *lenString = @"30";
	NSString *methodName =
	[NSString stringWithFormat:@"/api/1.0/project/%@/schedule/book?date=%@&location=%@&length=%@&page_id=%@&user_id=%@&service_id=1",
	 self.applicationKey, dateString, locString, lenString, request.page.id, user.userId];

	return [self POST:methodName params:nil];
}

- (RACSignal *)fetchRequestsForUser:(SLRUser *)user
{
	NSString *methodName = [NSString stringWithFormat:@"/api/1.0/user/bookings?user_id=%@", user.userId];
	return [[self GET:methodName params:nil]
		map:^NSArray<SLRRequest *> *(NSDictionary *bookingsDictionary) {
			NSArray<NSDictionary *> *bookingsArray = bookingsDictionary[@"bookings"];
			return [bookingsArray.rac_sequence map:^SLRRequest *(NSDictionary *requestDictionary) {
				return [[SLRRequest alloc] initWithDictionary:requestDictionary];
			}].array;
		}];
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

@end
