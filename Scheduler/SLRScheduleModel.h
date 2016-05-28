#import "SLRScheduleInterval.h"

#import "SLRTimeGrid.h"

@interface SLRScheduleModel : NSObject

@property (nonatomic, assign, readonly) BOOL canAdjustInterval;
@property (nonatomic, assign, readonly) NSInteger step;
@property (nonatomic, assign, readonly) NSRange availableRange;
@property (nonatomic, strong, readonly) NSArray<id<SLRScheduleInterval>> *scheduleIntervals;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (NSArray<id<SLRScheduleInterval>> *)allIntervals;

- (BOOL)canBookInterval:(id<SLRScheduleInterval>)interval;
- (BOOL)bookInterval:(id<SLRScheduleInterval>)interval;

@end
