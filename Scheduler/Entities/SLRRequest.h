#import "SLRSerializableProtocol.h"
#import "SLRService.h"
#import "SLRUser.h"
#import "SLRPage.h"

typedef NS_ENUM(NSInteger, SLRRequestState) {
	SLRRequestStateReview = 0,
	SLRRequestStateApprove = 1,
	SLRRequestStateReject = 2,

	SLRRequestStateUndefined = -1,
};

NS_ASSUME_NONNULL_BEGIN

/*! Объект-контейнер для составления запроса на букирование.
 *	Очень похож на SLRRange, но служит для составления запроса + отслеживания его прогресса.
 {
	"id": string,
	"page" : {
	},
	"user" : {
	...
	},
	"location" : UInteger,
	"length" : UInteger,
	"summary" : string,
	"state" : "review/approve/reject",
	"state_reason": string,
	"services" : (
		{
		...
		},
		{
		...
		}
	)
 }
 **/

@interface SLRRequest : NSObject

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, assign) NSInteger length;
@property (nonatomic, copy, nullable) NSString *summary;
@property (nonatomic, copy, nullable) NSArray<SLRService *> *services;
@property (nonatomic, strong, readonly) SLRPage *page;

@end

@interface SLRRequest (SLRDataProvider) <SLRSerializableProtocol>

/*! Выдается сервером? */
@property (nonatomic, copy, readonly, nullable) NSString *id;

/*! Текущий пользователь, заполняется при создании */
@property (nonatomic, strong, readonly) SLRUser *user;

/*! Состояние запроса - при создании undefined, потом выставляется сервером. */
@property (nonatomic, assign, readonly) SLRRequestState state;

/*! Обоснование стейта, например Rejected because you are in the company's blacklist. */
@property (nonatomic, copy, readonly) NSString *stateReason;

/*! Создает пустой реквест, который нужно заполнить данными, чтобы отправить на сервер.
 *	state = SLRRequestStateUndefined
	id = nil (присваивается сервером?)
	stateReason = nil ()
 **/
- (instancetype)initWithUser:(SLRUser *)user page:(SLRPage *)page;

/*! Сериализованное представление объекта. 
	Объект передается в запросах, поэтому его надо сериализовать.
 */
#warning Дописать методы
- (NSDictionary *)dictionary;

@end

@interface SLRRequest (SLRTesting)

+ (SLRRequest *)testRequestReviewed;

@end

NS_ASSUME_NONNULL_END
