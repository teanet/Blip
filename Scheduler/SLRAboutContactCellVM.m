#import "SLRAboutContactCellVM.h"

#import "SLRFilial.h"

@interface SLRAboutContactCellVM ()

@property (nonatomic, strong, readonly) SLRFilial *filial;

@end

@implementation SLRAboutContactCellVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_filial = filial;

	return self;
}

- (NSString *)address
{
	return self.filial.address;
}

@end
