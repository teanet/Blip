#import "SLROwner.h"

@implementation SLROwner

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_title = dictionary[@"title"];
	_subtitle = dictionary[@"subtitle"];
	_imageURLString = dictionary[@"image"];

	return self;
}

@end

@implementation SLROwner (SLRTesting)

+ (SLROwner *)testOwnerHairdresser
{
	return [SLROwner testOwnerWithName:@"ownerHairdresser.json"];
}

+ (SLROwner *)testOwnerDoctorOne
{
	return [SLROwner testOwnerWithName:@"ownerDoctorOne.json"];
}

+ (SLROwner *)testOwnerDoctorTwo
{
	return [SLROwner testOwnerWithName:@"ownerDoctorTwo.json"];
}

+ (SLROwner *)testOwnerDoctorThree
{
	return [SLROwner testOwnerWithName:@"ownerDoctorThree.json"];
}

+ (SLROwner *)testOwnerWithName:(NSString *)name
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
	NSDictionary *testDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	return [[SLROwner alloc] initWithDictionary:testDictionary];
}

@end
