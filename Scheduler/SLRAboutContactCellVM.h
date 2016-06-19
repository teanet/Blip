#import "SLRBaseVM.h"

@class SLRFilial;

@interface SLRAboutContactCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithFilial:(SLRFilial *)filial;

@end
