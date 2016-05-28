@class SLROwner;
@class SLRPage;
@class SLRRange;
@class SLRUser;
@class SLRRequest;

@protocol SLRAPIControllerProtocol <NSObject>

/*! \return SLRUser */
- (RACSignal *)fetchRegisteredUserForUser:(SLRUser *)user;

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date;

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range;

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return SLRRequest
 **/
- (RACSignal *)fetchProcessedRequestForRequest:(SLRRequest *)request;

/*! Отправляет букинг-реквест на сервер и возвращает обработанный реквест.
 *	\return @[SLRStoreItem]
 **/
- (RACSignal *)fetchStoreItems;

@end
