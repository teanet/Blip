#import "SLRSerializableProtocol.h"

/*! Правила, по которым пользователь может заполнять таблицу расписаний.
 {
	"id" : string,
	"booking_step" : 15,
	"booking_interval_min" : 15,
	"booking_interval_max" : 15,
 }
 */

@interface SLRTimeGrid : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;

/*! Шаг в минутах, на который мы можем изменить время букинга.
 *	Например, двигать плашечку забития времени с шагом 15 минут, и изменять длительность букирования с шагом 15 минут.
 **/
@property (nonatomic, assign, readonly) NSInteger bookingStep;

/*! Минимальное время в минутах букирования (например, 60 минут для стрижки - минимум).
 *	0 - не определено
 **/
@property (nonatomic, assign, readonly) NSInteger bookingIntervalMin;

/*! Максимальное время в минутах букирования (например, 180 минут для репетиции - максимум).
 *	0 - не определено
 **/
@property (nonatomic, assign, readonly) NSInteger bookingIntervalMax;

@end
