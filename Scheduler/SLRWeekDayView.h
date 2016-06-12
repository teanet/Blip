#import "SLRWeekDayVM.h"

@class SLRPage;

@interface SLRWeekDayView : UIButton

//@property (nonatomic, strong) SLRPage *page;
@property (nonatomic, strong) SLRWeekDayVM *viewModel;

- (instancetype)init;

@end
