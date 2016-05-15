#import "SLRRange.h"

@class SLRWorkDayVM;

@interface SLRIntervalVM : NSObject

@property (nonatomic, assign) BOOL editing;
@property (nonatomic, strong) SLRRange *range;
@property (nonatomic, weak) SLRWorkDayVM *workDayVM;

@end
