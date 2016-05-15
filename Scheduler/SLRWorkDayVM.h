#import "SLRIntervalVM.h"

@interface SLRWorkDayVM : NSObject

@property (nonatomic, assign, readonly) NSInteger step;
@property (nonatomic, assign, readonly) NSInteger minInterval;
@property (nonatomic, assign, readonly) NSInteger length;

- (void)insertInterval:(SLRIntervalVM *)intervalVM;
- (void)interval:(SLRIntervalVM *)intervalVM didChangeRange:(SLRRange *)range;

- (void)interval:(SLRIntervalVM *)intervalVM didUpdateLocation:(NSInteger)location;
- (void)intervalDidEndDragging:(SLRIntervalVM *)intervalVM;

- (NSArray<SLRIntervalVM *> *)intervalsVMAtMinute:(NSInteger)minute;
- (NSArray<SLRIntervalVM *> *)intervalsVMAtRange:(SLRRange *)range;

@end
