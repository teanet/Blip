#import "SLRFilial.h"

@implementation SLRFilial

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_title = dictionary[@"title"];
	_subtitle = dictionary[@"subtitle"];

	NSDictionary *aboutDictionary = dictionary[@"about"];
	_summary = aboutDictionary[@"description"];
	_mainImageURLString = dictionary[@"image"];

	NSDictionary *addressDictionary = dictionary[@"address"];
	_address = addressDictionary[@"name"];
	NSDictionary *pointDictionary = addressDictionary[@"point"];
	NSString *latString = pointDictionary[@"lat"];
	NSString *lonString = pointDictionary[@"lon"];
	_location = [[CLLocation alloc] initWithLatitude:[latString doubleValue] longitude:[lonString doubleValue]];

	_logoImageURLString = dictionary[@"logo"];

	NSArray<NSDictionary *> *phoneDictionariesArray = dictionary[@"phones"];
	NSDictionary *phoneDictionary = phoneDictionariesArray.firstObject;
	_phone = phoneDictionary[@"value"];

	NSArray <NSDictionary *> *ownerDictionaries = dictionary[@"masters"];
	if ([ownerDictionaries isKindOfClass:[NSArray class]])
	{
		_owners = [[ownerDictionaries rac_sequence]
			map:^SLROwner *(NSDictionary *ownerDictionary) {
				return [[SLROwner alloc] initWithDictionary:ownerDictionary];
			}].array;
	}

	NSArray <NSDictionary *> *purposeDictionaries = dictionary[@"services"];
	if ([purposeDictionaries isKindOfClass:[NSArray class]])
	{
		_purposes = [[purposeDictionaries rac_sequence]
		   map:^SLRPurpose *(NSDictionary *purposDictionariy) {
			   return [[SLRPurpose alloc] initWithDictionary:purposDictionariy];
		   }].array;
	}

	return self;
}

@end

@implementation SLRFilial (SLRTesting)

+ (SLRFilial *)testFilial
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"filial.json" ofType:nil]];
	NSDictionary *testDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	return [[SLRFilial alloc] initWithDictionary:testDictionary];
}

@end
