#import "SLRBaseVM.h"

#import "SLRStoreItem.h"

@interface SLRCartVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSArray<SLRStoreItem *> *storeItems;

- (void)updateItems;

@end
