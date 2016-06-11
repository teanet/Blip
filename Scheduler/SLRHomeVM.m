#import "SLRHomeVM.h"

#import "SLRDataProvider.h"
#import "SLRFilialVM.h"
#import "SLRSchedulerVM.h"

@implementation SLRHomeVM

/*! Получаем данные о филиалах, используем только первый филиал.
	Если в филиале только один purpose, то сразу показываем Scheduler.
	Если в филиале много purpose, то показываем экран Purposes.
 */
- (RACSignal *)initialViewModelSignal
{
	return [[[SLRDataProvider sharedProvider] fetchFilials]
		map:^SLRBaseVM *(NSArray<SLRFilial *> *filials) {
			SLRBaseVM *returnVM = nil;
			SLRFilial *filial = filials.firstObject;

			if (filial.purposes.count > 1)
			{
				returnVM = [[SLRFilialVM alloc] initWithFilial:filial];
			}
			else
			{
				// Здесь нужно сделать SLRFilialSchedulerVM сразу для всех owner'ов
				// SLRPurpose *purpose = filial.purposes.firstObject;
				// SLRFilialSchedulerVM *returnVM = [[SLRFilialSchedulerVM alloc] initWithFilial:filial purpose:purpose];
				SLROwner *owner = filial.owners.firstObject;
				returnVM = [[SLRSchedulerVM alloc] initWithOwner:owner];
			}

			return returnVM;
		}];
}

@end
