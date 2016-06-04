#import "SLRStoreItem.h"

@implementation SLRStoreItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self == nil) return nil;

	_id = dictionary[@"id"];
	_albumId = dictionary[@"album_id"];
	_ownerId = dictionary[@"owner_id"];
	_userId = dictionary[@"user_id"];
	_summary = dictionary[@"text"];
	_photoSmallURLString = dictionary[@"photo_130"];
	_photoLargeURLString = dictionary[@"photo_1280"];

	if (!_photoLargeURLString)
	{
		_photoLargeURLString = dictionary[@"photo_807"];
	}

	return self;
}

@end
