#import "SLRBaseVM.h"

#import "SLRPage.h"
#import <TLIndexPathController.h>

@class SLROwner;

@interface SLRSchedulerVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLRPage *page;

@property (nonatomic, copy, readonly) NSString *title;

/*! \sendNext NSDate */
@property (nonatomic, strong, readonly) RACSignal *didSelectDateSignal;

/*! returns [SLRIntervalVM] */
@property (nonatomic, strong, readonly) RACSignal *didSelectRangeSignal;

/*! Не используется */
@property (nonatomic, strong, readonly) RACSignal *didSelectPageSignal;

@property (nonatomic, strong, readonly) TLIndexPathController *indexPathController;

/*! На два месяца */
- (instancetype)init;
- (instancetype)initWithWeeksCountSinceNow:(NSInteger)weeksCount;

- (void)setPage:(SLRPage *)page forDate:(NSDate *)date;

- (void)registerTableView:(UITableView *)tableView;

@end
