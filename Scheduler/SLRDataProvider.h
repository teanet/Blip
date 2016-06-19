#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRService.h"
#import "SLRRequest.h"
#import "SLRProjectSettings.h"
#import "SLRStoreItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLRDataProvider : NSObject

+ (instancetype)sharedProvider;

@end

@interface SLRDataProvider (Authenticate)

- (SLRProjectSettings *)projectSettings;

/*! Текущий юзер, может быть nil */
- (SLRUser *)user;

/*! Авторизуем пользователя, запоминаем в кейчейн и возвращаем. */
- (RACSignal *)fetchAuthenticatedUser;

@end

@interface SLRDataProvider (CreateEntities)

- (RACSignal *)fetchEmptyBookingRequestForPage:(SLRPage *)page;

@end

@interface SLRDataProvider (SchedulerService)

///*! Подтягивает загруженность филиала. Загруженность = [0..1] заполненности дневного расписания.
// *	\return @{date: @(0..1)}
// **/
//- (RACSignal *)fetchWorkloadForFilial:(SLRFilial *)filial;

/*! Подтягивает все филиалы для проекта (приложения).
 *	\return @[SLRFilial]
 **/
- (RACSignal *)fetchFilials;

- (RACSignal *)fetchPageForOwner:(SLROwner *)owner date:(NSDate *)date;

- (RACSignal *)fetchNews;


/*! Подтягивает все виды целевых услуг филиала
 *	\return @[SLRPurpose]
 **/
- (RACSignal *)fetchPurposesForFilial:(SLRFilial *)filial;

/*! Подтягивает всех владельцев расписания для филиала.
 *	\return @[SLROwner]
 **/
- (RACSignal *)fetchOwnersForFilial:(SLRFilial *)filial;

/*! Подтягивает страницы расписания для владельца расписания (мастера/комнаты/бокса..) на дефолтную дату (сегодня).
 *	\return @[SLRPage]
 **/
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner;

/*! Подтягивает страницу расписания для владельца на нужную дату.
 *	\return @[SLRPage]
 **/
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date;

/*! Подтягивает дополнительные услуги (сервисы) для страницы расписания, время букинга.
 *	\return @[SLRService]
 **/
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range;




/*! Регистрирует пользователя с именем и телефоном. Возвращает уже зарегистрированного пользователя.
 *	\return @[SLRUser]
 **/
- (RACSignal *)fetchRegisteredUserForUser:(SLRUser *)user;

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return SLRRequest
 **/
- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request;

/*! Подтягивает букинг-реквесты для пользователя. Если пользователь не залогинен, логинит его по телефону.
 *	\return @[SLRRequest]
 **/
- (RACSignal *)fetchRequests;

@end

@interface SLRDataProvider (StoreService)

/*! Подтянуть товары для магазина
 *	Пока что подтягиваем просто фотки из вконтактика
 **/
- (RACSignal *)fetchStoreItems;

/*! Добавляет/убирает товар в/из корзину/ы
 *	Убрать потом в модель магазина
 **/
- (void)addStoreItemToCart:(SLRStoreItem *)storeItem;
- (void)removeStoreItemFromCart:(SLRStoreItem *)storeItem;

/*! Возвращает товары из корзины
 *	Убрать потом в модель магазина
 **/
- (NSArray<SLRStoreItem *> *)cartStoreItems;

@end

NS_ASSUME_NONNULL_END
