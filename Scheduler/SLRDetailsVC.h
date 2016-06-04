#import "SLRBaseVC.h"

#import "SLRDetailsVM.h"

/*! Экран, которые появляется, когда пользователь выбрал начало времени букирования.
	Это TableView, в котором в верхней секции выделено время минимального букирования,
	в секцию ниже добавляются доп.услуги.
	В самом низу кнопка "Забронировать"
 *
 **/

@interface SLRDetailsVC : SLRBaseVC <SLRDetailsVM *>

@end