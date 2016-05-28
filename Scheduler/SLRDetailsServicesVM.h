#import "SLRBaseVM.h"

@interface SLRDetailsServicesVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;

- (instancetype)initWithTitle:(NSString *)title;

@end
