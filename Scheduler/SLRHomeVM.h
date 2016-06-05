#import "SLRBaseVM.h"

@interface SLRHomeVM : SLRBaseVM

/*! Сигнал для показа ViewController'а. Прилетает viewModel контролллера, который нужно показать.
 *	\sendNext SLRBaseVM *
 **/
@property (nonatomic, copy, readonly) RACSignal *initialViewModelSignal;

@end
