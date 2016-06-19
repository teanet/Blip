#import "SLRMapVM.h"

@interface SLRMapView : UIView

@property (nonatomic, strong) SLRMapVM *viewModel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
