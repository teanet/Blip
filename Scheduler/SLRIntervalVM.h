#import "SLRRangeVM.h"

@class SLRWorkDayVM;

@interface SLRIntervalVM : NSObject

@property (nonatomic, assign) BOOL editing;
@property (nonatomic, strong) SLRRangeVM *range;
@property (nonatomic, weak) SLRWorkDayVM *workDayVM;

@end
