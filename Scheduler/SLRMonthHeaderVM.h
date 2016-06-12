#import "SLRBaseVM.h"

@interface SLRMonthHeaderVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *month;

- (instancetype)initWithDateComponents:(NSDateComponents *)components;

@end
