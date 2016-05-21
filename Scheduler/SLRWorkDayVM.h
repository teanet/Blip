#import "SLRIntervalVM.h"
#import "SLRPage.h"

@interface SLRWorkDayVM : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<SLRIntervalVM *> *intervals;

@property (nonatomic, assign, readonly) NSInteger step;
@property (nonatomic, assign, readonly) NSInteger minInterval;
@property (nonatomic, assign, readonly) NSInteger length;

- (instancetype)initWithPage:(SLRPage *)page NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)insertInterval:(SLRIntervalVM *)intervalVM;
- (void)interval:(SLRIntervalVM *)intervalVM didChangeRange:(SLRRangeVM *)range;

- (void)interval:(SLRIntervalVM *)intervalVM didUpdateLocation:(NSInteger)location;
- (void)intervalDidEndDragging:(SLRIntervalVM *)intervalVM;

- (NSArray<SLRIntervalVM *> *)intervalsVMAtMinute:(NSInteger)minute;
- (NSArray<SLRIntervalVM *> *)intervalsVMAtRange:(SLRRangeVM *)range;

@end
