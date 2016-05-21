#import "SLRPage.h"

@implementation SLRPage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	NSString *dateString = dictionary[@"date"];
	_date = [[SLRPage dateFormatter] dateFromString:dateString];

	NSArray <NSDictionary *> *rangeFreeDictinaries = dictionary[@"ranges_free"];
	_rangesFree = [SLRPage rangesFromDictionaries:rangeFreeDictinaries];

	NSArray <NSDictionary *> *rangeBookDictinaries = dictionary[@"ranges_book"];
	_rangesBook = [SLRPage rangesFromDictionaries:rangeBookDictinaries];

	NSArray <NSDictionary *> *rangeHoldDictinaries = dictionary[@"ranges_hold"];
	_rangesHold = [SLRPage rangesFromDictionaries:rangeHoldDictinaries];

	_timeGrid = [[SLRTimeGrid alloc] initWithDictionary:dictionary[@"greed"]];

	return self;
}

// MARK: Utils

+ (NSArray<SLRRange *> *)rangesFromDictionaries:(NSArray<NSDictionary *> *)rangeDictionaries
{
	NSArray<SLRRange *> *returnArray = nil;
	if ([rangeDictionaries isKindOfClass:[NSArray class]])
	{
		returnArray = [[rangeDictionaries rac_sequence]
			map:^SLRRange *(NSDictionary *rangeDictionary) {
			   return [[SLRRange alloc] initWithDictionary:rangeDictionary];
			}].array;
	}

	return returnArray;
}

+ (NSDateFormatter *)dateFormatter
{
	static dispatch_once_t onceToken;
	static NSDateFormatter *dateFormatter;
	dispatch_once(&onceToken, ^{
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
	});

	return dateFormatter;
}

@end

@implementation SLRPage (SLRTesting)

+ (SLRPage *)pageTest
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pages.json" ofType:nil]];
	NSDictionary *testDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	return [[SLRPage alloc] initWithDictionary:testDictionary];;
}

@end
