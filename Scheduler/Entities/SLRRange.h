#import "SLRSerializableProtocol.h"

#import "SLRService.h"
#import "SLRUser.h"

@class SLRIntervalVM;

typedef NS_ENUM(NSInteger, SLRRangeState) {
	SLRRangeStateFree = 0,
	SLRRangeStateHold = 1,
	SLRRangeStateBook = 2,

	SLRRangeStateUndefined = -1,
};

NS_ASSUME_NONNULL_BEGIN

/*! Диапазон времени, которое доступно для букинга, ждёт аппрува, или которое уже забукировано.
	Страница расписания (SLRPage) состоит из таких ренджей.
 {
	"user" : {
		...
	},
	"location" : UInteger,
	"length" : UInteger,
	"summary" : string,
	"state" : "free/hold/book",
	"services" : (
		{
			...
		},
		{
			...
		}
	)
 }
 */

@interface SLRRange : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, strong, readonly, nullable) SLRUser *user;
@property (nonatomic, assign, readonly) NSInteger location;
@property (nonatomic, assign, readonly) NSInteger length;
@property (nonatomic, copy, readonly, nullable) NSString *summary;
@property (nonatomic, assign, readonly) SLRRangeState state;
@property (nonatomic, copy, readonly, nullable) NSArray<SLRService *> *services;

+ (instancetype)rangeWithInterval:(SLRIntervalVM *)intervalVM bookingTime:(NSTimeInterval)bookingTime;

@end

NS_ASSUME_NONNULL_END
