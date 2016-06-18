#import "SLRBaseVM.h"

@class SLRFilial;

@interface SLRHomeVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLRBaseVM *showViewModel;

/*! Сигнал для показа ViewController'а. Прилетает viewModel контролллера, который нужно показать.
 *	\sendNext SLRBaseVM *
 **/
@property (nonatomic, strong, readonly) RACSignal *initialViewModelSignal;

- (instancetype)initWithFilials:(NSArray<SLRFilial *> *)filials;

@end
