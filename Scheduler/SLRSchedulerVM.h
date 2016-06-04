#import "SLRBaseVM.h"

#import "SLRPage.h"

@interface SLRSchedulerVM : SLRBaseVM
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong, readonly) SLRPage *page;

/** returns [SLRIntervalVM] */
@property (nonatomic, strong, readonly) RACSignal *didSelectRangeSignal;

- (instancetype)initWithPage:(SLRPage *)page NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)registerTableView:(UITableView *)tableView;

@end
