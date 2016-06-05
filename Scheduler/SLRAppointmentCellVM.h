#import "SLRBaseVM.h"

@class SLRRequest;

@interface SLRAppointmentCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *text;

- (instancetype)initWithRequest:(SLRRequest *)request NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
