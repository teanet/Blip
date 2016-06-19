#import "SLRNews.h"

@implementation SLRNews

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_title = dictionary[@"title"];
	_imageURLString = dictionary[@"image"];
	_summary = dictionary[@"text"];
	_dateString = dictionary[@"date"];

	return self;
}

@end
