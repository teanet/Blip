#import "SLRBaseVM.h"

#import "SLRPage.h"
#import "SLRRange.h"
#import "SLRServiceCellVM.h"

/*! ВьюМодель экрана заполнения деталей заказа (появляется после выбора стартового времени).
 *	- Здесь мы получаем дополнительные сервисы с сервера, и создаем SLRRequest - объект, который
	является запросом на букинг. 
	- Результатом обработки такого реквеста сервером будет появление SLRRange в нужном месте.
 **/
@interface SLRDetailsVM : SLRBaseVM

/*! Сигнал о том, что мы успешно забукались
 *	\sendNext SLRRequest
 **/
@property (nonatomic, strong, readonly) RACSignal *didBookSignal;

/*! Это результат преждевременной оптимизации.
 *	На пропертю надо подписаться, и когда YES - закрывать всё серой вьюхой с лоадером - ходим на сервер.
 **/
@property (atomic, assign, readonly, getter=isServiceProcessing) BOOL serviceProcessing;

- (instancetype)initWithPage:(SLRPage *)page selectedRange:(SLRRange *)selectedRange;
- (instancetype)init NS_UNAVAILABLE;

/*! Обрабатываем нажатие на кнопку букинга
 *	Формируем реквест, отправляем на сервер. 
	Если все ок, то закрываем вьюконтроллер, и обновляем таблицу с расписанием - там должен появиться наш рендж.
	Если не ок - показываем ошибку.
 **/
- (void)didTapBookButton;

@end


@interface SLRDetailsVM (UITableView)

/*! Сигнал для апдейта тэйблвьюхи
 *	\sendNext [RACUnit defaultUnit]
 **/
@property (nonatomic, strong, readonly) RACSignal *shouldUpdateTableViewSignal;

- (id<SLRTableViewCellVMProtocol>)cellVMForIndexPath:(NSIndexPath *)indexPath;
- (SLRBaseVM *)headerVMForSection:(NSUInteger)section;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsForSection:(NSUInteger)section;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
