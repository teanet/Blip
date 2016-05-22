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

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *fullName;
@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *token;

/*! Создаем пользователя локально и регистрируем на сервере. */
- (instancetype)initWithFullName:(NSString *)fullName
						   phone:(NSString *)phone;

- (NSDictionary *)dictionary;

@end
