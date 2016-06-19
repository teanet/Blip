#import "SLROwnerVM.h"

@interface SLROwnerVM ()

@property (nonatomic, strong, readonly) SLROwner *owner;

@end

@implementation SLROwnerVM

- (instancetype)initWithOwner:(SLROwner *)owner selected:(BOOL)selected
{
	self = [super init];
	if (self == nil) return nil;

	_owner = owner;
	_selected = selected;

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
