#import "SLRBaseVM.h"

@class SLROwnersVM;
@class SLRPurpose;
@class SLRSchedulerVM;

@interface SLRFilialSchedulerVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLROwnersVM *ownersVM;
@property (nonatomic, strong, readonly) SLRSchedulerVM *schedulerVM;
@property (nonatomic, assign, readonly) BOOL shouldShowOwnersPicker;

- (instancetype)initWithPurposes:(NSArray <SLRPurpose *> *)purposes;

@end
