#import "SLRBaseVM.h"

@class SLROwnersVM;
@class SLROwner;
@class SLRPurpose;
@class SLRSchedulerVM;

@interface SLRFilialSchedulerVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLROwnersVM *ownersVM;
@property (nonatomic, strong, readonly) SLRSchedulerVM *schedulerVM;
@property (nonatomic, assign, readonly) BOOL shouldShowOwnersPicker;

- (instancetype)initWithPurposes:(NSArray <SLRPurpose *> *)purposes owners:(NSArray<SLROwner *> *)owners;

@end
