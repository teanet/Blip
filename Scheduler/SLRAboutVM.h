#import "SLRBaseVM.h"

@class SLRMapVM;

@interface SLRAboutVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) SLRMapVM *mapVM;

- (void)registerTableView:(UITableView *)tableView;

@end
