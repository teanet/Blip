#import "SLRSerializableProtocol.h"

/*! Целевая услуга, которую предоставляет организация, и на которую хочет записаться пользователь - 
	это стрижка в парикмахерской, заправка картриджей, замена масла на СТО, аренда зала на точке или фотостудии, 
	направление врача, к которому хочется прийти на прием.

	{
	 "id": "string",
	 "title": "string",
	 "subtitle": "string",
	 "image": "url",
	 "price": integer,
	 "price_per_time_unit": integer, // 500р
	 "time_unit": integer, // 180 минут
	 "can_multiple_select": bool,
	 "booking_interval_min" : integer, // 180 минут
	 "booking_interval_max" : integer, // 180 минут
	}
 */

@interface SLRPurpose : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *imageURLString;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, assign, readonly) NSInteger price;
@property (nonatomic, assign, readonly) NSInteger pricePerTimeUnit;
@property (nonatomic, assign, readonly) NSInteger timeUnit;
@property (nonatomic, assign, readonly) BOOL canMultipleSelect;
@property (nonatomic, assign, readonly) NSInteger bookingIntervalMin;
@property (nonatomic, assign, readonly) NSInteger bookingIntervalMax;

@end

@interface SLRPurpose (SLRTesting)

+ (NSArray <SLRPurpose *> *)testPurposes;

@end
