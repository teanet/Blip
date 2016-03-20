#import "SLRScheduleInterval.h"

@interface SLRVisitorInterval : NSObject
<SLRScheduleInterval>

- (instancetype)initWithTitle:(NSString *)title range:(NSRange)range NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
