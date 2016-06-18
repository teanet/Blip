@class SLROwner;
@class SLRPage;
@class SLRRange;
@class SLRUser;
@class SLRRequest;
@class SLRFilial;
@class SLRProjectSettings;

@protocol SLRAPIControllerProtocol <NSObject>

@property (nonatomic, strong, readonly) SLRProjectSettings *projectSettings;

/*! \return SLRUser */
- (RACSignal *)fetchRegisteredUserForUser:(SLRUser *)user;

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials;

/*! \return SLRPage
 */
- (RACSignal *)fetchPageForOwner:(SLROwner *)owner date:(NSDate *)date;




/*! Подтягивает все виды целевых услуг филиала
 *	\return @[SLRPurpose]
 **/
- (RACSignal *)fetchPurposesForFilial:(SLRFilial *)filial;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner;

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range;

/*! \return @[SLROwner] */
- (RACSignal *)fetchOwnersForFilial:(SLRFilial *)filial;

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return SLRRequest
 **/
- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request user:(SLRUser *)user;

/*! Подтягивает все реквесты для пользователя.
 *	\return @[SLRRequest]
 **/
- (RACSignal *)fetchRequestsForUser:(SLRUser *)user;

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return @[SLRStoreItem]
 **/
- (RACSignal *)fetchStoreItems;

@end
