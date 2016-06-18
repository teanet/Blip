#import "SLRBaseVM.h"

@class SLRFilial;

@interface SLRFilialInfoVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *logoImageURLString;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *summary;

- (instancetype)initWithFilial:(SLRFilial *)filial;

@end
