#import "SLRBaseVM.h"

#import "SLRMapVM.h"

@class SLRFilial;

@interface SLRAboutContactCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, strong, readonly) SLRMapVM *mapVM;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithFilial:(SLRFilial *)filial;

@end
