#import "SLRSerializableProtocol.h"

/*! Дополнительный сервис, который может выбрать пользователь.
 *	{
		"id": string, - уникальный идентификатор
		"title": string, - название сервиса
		"summary": string, - описание сервиса
		"price_per_minute": NSInteger, - стоимость за минуту (или 0)
		"price": NSInteger, - стоимость за пользование сервиса (единичная)
		"duration": NSInteger, - дополнительное время, необходимое на пользование сервиса
		"available": BOOL, - доступен ли сервис
		"selected": BOOL - выбран ли сервис
	}
 **/
@interface SLRService : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, assign, readonly) NSInteger price;
@property (nonatomic, assign, readonly) NSInteger pricePerMinute;
@property (nonatomic, assign, readonly) NSInteger duration;
@property (nonatomic, assign, readonly) BOOL available;
@property (nonatomic, assign, readwrite) BOOL selected;

@end

@interface SLRService (SLRTesting)

+ (NSArray <SLRService *> *)testServices;®

@end