#import "SLRBaseVM.h"

@class SLRFilial;

@interface SLRFilialVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;

- (instancetype)initWithFilial:(SLRFilial *)filial;

@end
