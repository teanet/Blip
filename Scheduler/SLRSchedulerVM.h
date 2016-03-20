#import "SLRBaseVM.h"

#import "SLRScheduleModel.h"

@interface SLRSchedulerVM : SLRBaseVM
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

- (instancetype)initWithModel:(SLRScheduleModel *)model NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
