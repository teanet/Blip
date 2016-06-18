#import "SLRFilialInfoVM.h"

@interface SLRFilialInfoVM ()

@property (nonatomic, strong, readonly) SLRFilial *filial;

@end

@implementation SLRFilialInfoVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_filial = filial;

	return self;
}

@end
