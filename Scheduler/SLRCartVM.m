#import "SLRCartVM.h"

#import "SLRDataProvider.h"

@interface SLRCartVM ()

@property (nonatomic, copy, readwrite) NSArray<SLRStoreItem *> *storeItems;

@end

@implementation SLRCartVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	[self updateItems];

	return self;
}

- (void)updateItems
{
	self.storeItems = [[SLRDataProvider sharedProvider] cartStoreItems];
}

@end
