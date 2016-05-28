#import "SLRStoreVM.h"

#import "SLRDataProvider.h"

@interface SLRStoreVM ()

@property (nonatomic, copy, readwrite) NSArray<SLRStoreItem *> *storeItems;

@end

@implementation SLRStoreVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	@weakify(self);

	[[[SLRDataProvider sharedProvider] fetchStoreItems]
		subscribeNext:^(NSArray<SLRStoreItem *> *items) {
			@strongify(self);

			self.storeItems = items;
		}];

	return self;
}

@end
