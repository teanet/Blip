#import "SLRAppointmentCellVM.h"

#import "SLRRequest.h"


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
