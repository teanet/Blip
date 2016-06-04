#import "SLROwnerVM.h"

@interface SLROwnerVM ()

@property (nonatomic, strong, readonly) SLROwner *owner;

@end

@implementation SLROwnerVM

- (instancetype)initWithOwner:(SLROwner *)owner
{
	self = [super init];
	if (self == nil) return nil;

	_owner = owner;

	return self;
}

- (NSString *)imageURLString
{
	return self.owner.imageURLString;
}

- (NSString *)title
{
	return self.owner.title;
}

- (NSString *)subtitle
{
	return self.owner.subtitle;
}

@end
