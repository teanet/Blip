#import "SLRTableViewCellVMProtocol.h"

// Additional height for the cell separator height
// http://www.raywenderlich.com/73602/dynamic-table-view-cell-height-auto-layout
extern CGFloat const kSLRTableViewCellSeparatorHeight;

@interface SLRTableViewCell<ViewModelType> : UITableViewCell <SLRTableViewCellVMDelegate>

@property (nonatomic, strong, readwrite) ViewModelType viewModel;

@end