#import "SLRFilialVM.h"

#import "SLRFilial.h"
#import "SLROwnerVM.h"

@interface SLRFilialVM ()

@property (nonatomic, strong, readonly) SLRFilial *filial;

@end

@implementation SLRFilialVM

- (instancetype)initWithFilial:(SLRFilial *)filial
{
	self = [super init];
	if (self == nil) return nil;

	_filial = filial;
	_ownerVMs = [self.filial.owners.rac_sequence
		map:^SLROwnerVM *(SLROwner *owner) {
			return [[SLROwnerVM alloc] initWithOwner:owner];
		}].array;

	return self;
}

- (NSString *)title
{
	return self.filial.title;
}

@end
