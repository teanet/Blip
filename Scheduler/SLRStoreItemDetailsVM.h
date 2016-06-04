#import "SLRBaseVM.h"

#import "SLRStoreItem.h"

typedef NS_ENUM(NSInteger, SLRStoreItemDetailsStyle) {
	SLRStoreItemDetailsStyleAdd = 0,
	SLRStoreItemDetailsStyleRemove = 1
};

@interface SLRStoreItemDetailsVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLRStoreItem *storeItem;
@property (nonatomic, assign, readonly) SLRStoreItemDetailsStyle style;

- (instancetype)initWithStoreItem:(SLRStoreItem *)storeItem style:(SLRStoreItemDetailsStyle)style;

@end
