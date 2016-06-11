#import "SLRFilial.h"

@implementation SLRFilial

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_title = dictionary[@"title"];
	_address = dictionary[@"address"];
	_contact = dictionary[@"contact"];

	NSArray <NSDictionary *> *ownerDictionaries = dictionary[@"owners"];
	if ([ownerDictionaries isKindOfClass:[NSArray class]])
	{
		_owners = [[ownerDictionaries rac_sequence]
			map:^SLROwner *(NSDictionary *ownerDictionary) {
				return [[SLROwner alloc] initWithDictionary:ownerDictionary];
			}].array;
	}

	NSArray <NSDictionary *> *purposeDictionaries = dictionary[@"purposes"];
	if ([ownerDictionaries isKindOfClass:[NSArray class]])
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
