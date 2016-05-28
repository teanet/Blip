#import "SLRTableViewHeaderFooterViewProtocol.h"

@interface SLRTableViewHeaderFooterView<ViewModel> : UITableViewHeaderFooterView <SLRTableViewHeaderFooterViewProtocol>

@property (nonatomic, strong) ViewModel viewModel;

@end
