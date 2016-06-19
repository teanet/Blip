#import "SLRBaseVM.h"

#import "SLRRequest.h"

@interface SLRAppointmentCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, strong, readonly) SLRRequest *request;

- (instancetype)initWithRequest:(SLRRequest *)request NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
