#import "SLRFilialVM.h"

#import "SLRFilial.h"

@interface SLRFilialVM ()

@property (nonatomic, strong, readonly) SLRFilial *filial;

@end

@implementation SLRFilialVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_filial = filial;

	return self;
}

- (NSString *)title
{
	return self.filial.title;
}

@end
