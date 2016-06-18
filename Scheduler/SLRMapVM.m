#import "SLRMapVM.h"

#import "SLRFilial.h"

@interface SLRMapVM ()

@property (nonatomic, strong, readonly) SLRFilial *filial;

@end

@implementation SLRMapVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_filial = filial;
	_location = filial.location;

	return self;
}

@end
