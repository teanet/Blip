#import "SLRBaseVM.h"

#import "SLRPurpose.h"

@interface SLRPurposesVM : SLRBaseVM

- (instancetype)initWithPurposes:(NSArray <SLRPurpose *> *)purposes;

- (void)registerTableView:(UITableView *)tableView;

- (CGFloat)contentHeight;

@end
