#import "SLRHomeVM.h"

#import "SLRDataProvider.h"
#import "SLRFilialVM.h"
#import "SLRSchedulerVM.h"

@interface SLRHomeVM ()

@property (nonatomic, copy, readonly) NSArray<SLRFilial *> *filials;

@end

@implementation SLRHomeVM

/*! Получаем данные о филиалах, используем только первый филиал.
	Если в филиале только один purpose, то сразу показываем Scheduler.
	Если в филиале много purpose, то показываем экран Purposes.
 */
- (instancetype)initWithFilials:(NSArray<SLRFilial *> *)filials
{
	self = [super init];
	if (self == nil) return nil;

	_filials = [filials copy];
	_title = @"Запись";

	[self defineViewModelForShowing];

	return self;
}

- (void)defineViewModelForShowing
{
	SLRFilial *filial = self.filials.firstObject;

	if (filial.purposes.count > 1)
	{
		_showViewModel = [[SLRFilialVM alloc] initWithFilial:filial];
	}
	else
	{
		// Здесь нужно сделать SLRFilialSchedulerVM сразу для всех owner'ов
		// SLRPurpose *purpose = filial.purposes.firstObject;
		// SLRFilialSchedulerVM *returnVM = [[SLRFilialSchedulerVM alloc] initWithFilial:filial purpose:purpose];
		SLROwner *owner = filial.owners.firstObject;
		//				returnVM = [[SLRSchedulerVM alloc] initWithOwner:owner];
	}
}

@end
