#import "SLRRange.h"

@class SLRPage;

@interface SLRIntervalVM : NSObject

@property (nonatomic, weak) SLRPage *page;
@property (nonatomic, assign) SLRRangeState state;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, assign) NSInteger length;

+ (NSArray<SLRIntervalVM *> *)intervalsForRange:(SLRRange *)range step:(NSInteger)step;

- (UIColor *)color;
- (NSString *)timeString;

@end
