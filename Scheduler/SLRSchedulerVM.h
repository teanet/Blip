#import "SLRBaseVM.h"

#import "SLRPage.h"
#import <TLIndexPathController.h>

@class SLROwner;

@interface SLRSchedulerVM : SLRBaseVM
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) SLRPage *page;

@property (nonatomic, copy, readonly) NSString *title;

/** returns [SLRIntervalVM] */
@property (nonatomic, strong, readonly) RACSignal *didSelectRangeSignal;

@property (nonatomic, strong, readonly) RACSignal *didSelectPageSignal;

@property (nonatomic, strong, readonly) TLIndexPathController *indexPathController;

- (void)registerTableView:(UITableView *)tableView;

- (instancetype)initWithOwner:(SLROwner *)owner;
- (instancetype)init NS_UNAVAILABLE;

@end
