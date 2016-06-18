#import "SLRBaseVM.h"

@class SLRFilial;

@interface SLRMapVM : SLRBaseVM

@property (nonatomic, strong, readonly) CLLocation *location;

- (instancetype)initWithFilial:(SLRFilial *)filial NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
