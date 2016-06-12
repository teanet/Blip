#import "SLRWeekHeaderVM.h"

#import "SLRTableViewHeaderFooterView.h"

@class SLRPage;
@protocol SLRWeekHeaderViewDelegate;

@interface SLRWeekHeaderView : SLRTableViewHeaderFooterView <SLRWeekHeaderVM *>

@property (nonatomic, weak) id<SLRWeekHeaderViewDelegate> delegate;

@end

@protocol SLRWeekHeaderViewDelegate <NSObject>

- (void)weekHeaderView:(SLRWeekHeaderView *)weekHeaderView didSelectDay:(SLRWeekDayVM *)dayVM;

@end
