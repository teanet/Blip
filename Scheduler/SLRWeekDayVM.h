#import "SLRBaseVM.h"

@interface SLRWeekDayVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, assign, readonly) NSInteger month;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign, readonly) BOOL interactive;

- (instancetype)initWithDate:(NSDate *)date month:(NSInteger)month;

@end
