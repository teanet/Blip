#import "SLRSerializableProtocol.h"

/*! Пользователь, который заполняет таблицу расписаний.
	Администратор - тоже пользователь, но его ещё не бывает.
 {
	"id" : string,
	"full_name" : string,
	"phone" : string,
 }
 */
@interface SLRUser : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *userId;
@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *authToken;
@property (nonatomic, copy, readonly) NSString *authTokenSecret;

/*! Создаем пользователя локально и регистрируем на сервере. */
- (instancetype)initWithUserId:(NSString *)userId
				     authToken:(NSString *)authToken
			   authTokenSecret:(NSString *)authTokenSecret
						 phone:(NSString *)phone;

- (NSDictionary *)dictionary;

@end
