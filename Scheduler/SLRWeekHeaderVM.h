#import "SLRBaseVM.h"

#import "SLRPage.h"

@class SLRWeekDayVM;

@interface SLRWeekHeaderVM : SLRBaseVM

@property (nonatomic, weak) SLRPage *selectedPage;

@property (nonatomic, copy, readonly) NSArray<SLRWeekDayVM *> *dayVMs;

- (instancetype)initWithStartDate:(NSDate *)startDate month:(NSInteger)month;
- (instancetype)init NS_UNAVAILABLE;

- (void)didSelectDay:(SLRWeekDayVM *)selectedDayVM;

@end
