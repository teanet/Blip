@class SLROwner;
@class SLRPage;
@class SLRRange;
@class SLRUser;
@class SLRRequest;
@class SLRFilial;

@protocol SLRAPIControllerProtocol <NSObject>

/*! \return SLRUser */
- (RACSignal *)fetchRegisteredUserForUser:(SLRUser *)user;

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials;

/*! Подтягивает все виды целевых услуг филиала
 *	\return @[SLRPurpose]
 **/
- (RACSignal *)fetchPurposesForFilial:(SLRFilial *)filial;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date;

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range;

/*! \return @[SLROwner] */
- (RACSignal *)fetchOwnersForFilial:(SLRFilial *)filial;

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return SLRRequest
 **/
- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request;

/*! Подтягивает все реквесты для пользователя.
 *	\return @[SLRRequest]
 **/
- (RACSignal *)fetchRequestsForUser:(SLRUser *)user;

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return @[SLRStoreItem]
 **/
- (RACSignal *)fetchStoreItems;

@end
