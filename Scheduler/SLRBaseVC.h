#import "SLRBaseVM.h"

@interface SLRBaseVC<ViewModelClass> : UIViewController

- (instancetype)initWithViewModel:(ViewModelClass)viewModel;
- (ViewModelClass)viewModel;

@end
