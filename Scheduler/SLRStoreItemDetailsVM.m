#import "SLRStoreItemDetailsVM.h"

@implementation SLRStoreItemDetailsVM

- (instancetype)initWithStoreItem:(SLRStoreItem *)storeItem style:(SLRStoreItemDetailsStyle)style
{
	self = [super init];
	if (self == nil) return nil;

	_storeItem = storeItem;
	_style = style;

	return self;
}

@end
