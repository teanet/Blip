#import "SLRBaseVM.h"

@class SLROwnersVM;
@class SLROwner;
@class SLRPurpose;
@class SLRSchedulerVM;

@interface SLRFilialSchedulerVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLROwnersVM *ownersVM;
@property (nonatomic, strong, readonly) SLRSchedulerVM *schedulerVM;
@property (nonatomic, assign, readonly) BOOL shouldShowOwnersPicker;

@property (nonatomic, strong, readonly) RACSignal *shouldShowDetailsSignal;

- (instancetype)initWithPurposes:(NSArray <SLRPurpose *> *)purposes owners:(NSArray<SLROwner *> *)owners;

- (void)reloadCurrentPage;

@end
