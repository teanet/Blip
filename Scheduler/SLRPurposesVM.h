#import "SLRBaseVM.h"

#import "SLRPurpose.h"

@interface SLRPurposesVM : SLRBaseVM

/*! Сигнал о выборе услуги
 *	\sendNext SLRPurpose
 **/
@property (nonatomic, strong, readonly) RACSignal *didSelectPurposeSignal;

- (instancetype)initWithPurposes:(NSArray <SLRPurpose *> *)purposes;

- (void)registerTableView:(UITableView *)tableView;

- (CGFloat)contentHeight;

@end
