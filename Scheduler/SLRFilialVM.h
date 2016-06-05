#import "SLRBaseVM.h"

@class SLRFilial;
@class SLROwnerVM;

@interface SLRFilialVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSArray<SLROwnerVM *> *ownerVMs;

/*! Сигнал о том, что выбран Owner
 *	\sendNext SLRSchedulerVM
 **/
@property (nonatomic, strong, readonly) RACSignal *shouldShowSchedulerSignal;

- (instancetype)initWithFilial:(SLRFilial *)filial;
- (void)didSelectOwnerAtIndexPath:(NSIndexPath *)indexPath;

@end
