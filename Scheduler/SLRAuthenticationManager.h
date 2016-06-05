@class SLRUser;

@interface SLRAuthenticationManager : NSObject

/*! Возвращает возможно зарегистрированного пользователя.
 *	Если пользователь не зарегистрирован, то nil.
 **/
@property (nonatomic, strong, readonly) SLRUser *user;

/*! Сигнал с точно зарегистрированным пользователем в sendNext.
 *	Если пользователь не зарегался, то регистрируем по смс.
 **/
- (RACSignal *)fetchAuthenticatedUser;

@end
