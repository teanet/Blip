#import "SLRBaseVM.h"

#import "SLRPage.h"
#import "SLRRange.h"

@interface SLRDetailsVM : SLRBaseVM

- (instancetype)initWithPage:(SLRPage *)page selectedRange:(SLRRange *)selectedRange;

@end
