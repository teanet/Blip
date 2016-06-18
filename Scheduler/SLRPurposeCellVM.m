#import "SLRPurposeCellVM.h"

@interface SLRPurposeCellVM ()

@property (nonatomic, strong, readonly) SLRPurpose *purpose;

@end

@implementation SLRPurposeCellVM

- (instancetype)initWithPurpose:(SLRPurpose *)purpose
{
	self = [super init];
	if (self == nil) return nil;

	_purpose = purpose;

	return self;
}

- (NSString *)title
{
	return self.purpose.title;
}

- (NSString *)subtitle
{
	return self.purpose.subtitle;
}

@end
