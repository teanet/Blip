#import "SLRPage.h"

#import "SLRIntervalVM.h"

@implementation SLRPage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	NSString *dateString = dictionary[@"date"];
	_date = [[SLRPage dateFormatter] dateFromString:dateString];

	NSDictionary *ownerDictionary = dictionary[@"owner"];
	_owner = [[SLROwner alloc] initWithDictionary:ownerDictionary];

	NSArray <NSDictionary *> *rangeFreeDictinaries = dictionary[@"ranges_free"];
	_rangesFree = [SLRPage rangesFromDictionaries:rangeFreeDictinaries];

	NSArray <NSDictionary *> *rangeBookDictinaries = dictionary[@"ranges_book"];
	_rangesBook = [SLRPage rangesFromDictionaries:rangeBookDictinaries];

	NSArray <NSDictionary *> *rangeHoldDictinaries = dictionary[@"ranges_hold"];
	_rangesHold = [SLRPage rangesFromDictionaries:rangeHoldDictinaries];

	_timeGrid = [[SLRTimeGrid alloc] initWithDictionary:dictionary[@"grid"]];

	NSMutableArray<SLRIntervalVM *> *intervals = [NSMutableArray array];
	[self.rangesFree enumerateObjectsUsingBlock:^(SLRRange *freeRange, NSUInteger _, BOOL *__) {
		[intervals addObjectsFromArray:[SLRIntervalVM intervalsForRange:freeRange step:self.timeGrid.bookingStep]];
	}];

	[self.rangesBook enumerateObjectsUsingBlock:^(SLRRange *freeRange, NSUInteger _, BOOL *__) {
		[intervals addObjectsFromArray:[SLRIntervalVM intervalsForRange:freeRange step:self.timeGrid.bookingStep]];
	}];

	[self.rangesHold enumerateObjectsUsingBlock:^(SLRRange *freeRange, NSUInteger _, BOOL *__) {
		[intervals addObjectsFromArray:[SLRIntervalVM intervalsForRange:freeRange step:self.timeGrid.bookingStep]];
	}];

	[intervals enumerateObjectsUsingBlock:^(SLRIntervalVM *intervalVM, NSUInteger idx, BOOL * _Nonnull stop) {
	}];

	[intervals sortWithOptions:NSSortStable usingComparator:^NSComparisonResult(SLRIntervalVM *obj1, SLRIntervalVM *obj2) {
		return obj1.location < obj2.location ? NSOrderedAscending : NSOrderedDescending;
	}];
	_intervals = [intervals copy];

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
		[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	});

	return dateFormatter;
}

@end

@implementation SLRPage (SLRTesting)

+ (SLRPage *)testPageWithDate:(NSString *)dateString
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pages.json" ofType:nil]];
	NSDictionary *testDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	SLRPage *page = [[SLRPage alloc] initWithDictionary:testDictionary];
	if (dateString)
	{
		page.dateString = dateString;
	}
	return page;
}

+ (SLRPage *)testPage
{
	return [self testPageWithDate:nil];
}

@end
