#import "SLRService.h"

@implementation SLRService

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_title = dictionary[@"title"];
	_summary = dictionary[@"summary"];
	_price = [dictionary[@"price"] integerValue];
	_pricePerMinute = [dictionary[@"price_per_minute"] integerValue];
	_duration = [dictionary[@"duration"] integerValue];
	_available = [dictionary[@"available"] boolValue];
	_selected = [dictionary[@"selected"] boolValue];

	return self;
}

@end

@implementation SLRService (SLRTesting)

+ (NSArray <SLRService *> *)testServices
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"services.json" ofType:nil]];
	NSArray *testArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	return [testArray.rac_sequence
		map:^SLRService *(NSDictionary *dictionary) {
			return [[SLRService alloc] initWithDictionary:dictionary];
		}].array;
}

@end
