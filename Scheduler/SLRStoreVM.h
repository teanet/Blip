#import "SLRBaseVM.h"

#import "SLRStoreItem.h"

@interface SLRStoreVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSArray<SLRStoreItem *> *storeItems;

@end
