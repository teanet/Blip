#import "SLRBaseVM.h"

#import <MSCollectionViewCalendarLayout.h>
#import "SLRScheduleModel.h"

@interface SLRSchedulerVM : SLRBaseVM
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, strong, readonly) MSCollectionViewCalendarLayout *collectionViewCalendarLayout;

- (instancetype)initWithModel:(SLRScheduleModel *)model NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)registerCollectionView:(UICollectionView *)collectionView;

@end
