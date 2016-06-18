#import "SLRBaseVM.h"

@class SLRMapVM;
@class SLRFilial;

@interface SLRAboutVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) SLRMapVM *mapVM;

- (instancetype)initWithFilial:(SLRFilial *)filial NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)registerTableView:(UITableView *)tableView;

@end
