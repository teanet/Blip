#import "SLRScheduleInterval.h"

@interface SLRFreeInterval : NSObject
<SLRScheduleInterval>

- (instancetype)initWithRange:(NSRange)range NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
