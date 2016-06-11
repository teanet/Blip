#import "SLRBaseVM.h"

@class SLRFilial;
@class SLROwnersVM;
@class SLRPurposesVM;

@interface SLRFilialVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) SLROwnersVM *ownersVM;
@property (nonatomic, copy, readonly) SLRPurposesVM *purposesVM;

/*! Сигнал о том, что выбран Owner
 *	\sendNext SLRSchedulerVM
 **/
@property (nonatomic, strong, readonly) RACSignal *shouldShowSchedulerSignal;

- (instancetype)initWithFilial:(SLRFilial *)filial;
- (void)registerTableView:(UITableView *)tableView;

@end
