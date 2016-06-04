@class SLRPage;
@protocol SLRWeekHeaderViewDelegate;

#import "SLRWeekHeaderVM.h"

@interface SLRWeekHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) SLRWeekHeaderVM *weekVM;
@property (nonatomic, weak) id<SLRWeekHeaderViewDelegate> delegate;

@end

@protocol SLRWeekHeaderViewDelegate <NSObject>

- (void)weekHeaderView:(SLRWeekHeaderView *)weekHeaderView didSelectPage:(SLRPage *)page;

@end
