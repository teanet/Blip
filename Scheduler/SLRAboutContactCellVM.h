#import "SLRBaseVM.h"

@class SLRFilial;

@interface SLRAboutContactCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *address;

- (instancetype)initWithFilial:(SLRFilial *)filial;

@end
