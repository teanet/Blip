#import "SLRFilialInfoVM.h"

#import "SLRFilial.h"

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

- (NSString *)title
{
	return self.filial.title;
}

- (NSString *)logoImageURLString
{
	return self.filial.logoImageURLString;
}

- (NSString *)summary
{
	return self.filial.summary;
}

@end
