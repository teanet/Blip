#import "SLRBaseVM.h"

@class SLRFilial;
@class SLROwnerVM;

@interface SLRFilialVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSArray<SLROwnerVM *> *ownerVMs;

- (instancetype)initWithFilial:(SLRFilial *)filial;

@end
