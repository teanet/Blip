#import "SLRIntervalVM.h"

CGFloat slr_pointsFromMinutes(NSInteger minutes);
CGFloat slr_minutesFromPoints(CGFloat points);

@interface SLRIntervalView : UIView

@property (nonatomic, strong) SLRIntervalVM *intervalVM;

@end
