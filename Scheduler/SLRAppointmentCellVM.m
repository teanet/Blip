#import "SLRAppointmentCellVM.h"

#import "SLRRequest.h"

@interface SLRAppointmentCellVM ()

@property (nonatomic, strong, readonly) SLRRequest *request;

@end

@implementation SLRAppointmentCellVM

- (instancetype)initWithRequest:(SLRRequest *)request
{
	self = [super init];
	if (self == nil) return nil;

	_request = request;

	return self;
}

- (NSString *)text
{
	return self.request.summary;
}

@end
