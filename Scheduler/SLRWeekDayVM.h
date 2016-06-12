#import "SLRBaseVM.h"

@interface SLRWeekDayVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithDate:(NSDate *)date;

@end
