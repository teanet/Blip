#import "SLRBaseVM.h"

@interface SLRBaseVC : UIViewController

@property (nonatomic, strong, readonly) SLRBaseVM *viewModel;

- (instancetype)initWithViewModel:(SLRBaseVM *)viewModel;

@end
