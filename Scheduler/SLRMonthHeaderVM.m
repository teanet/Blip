#import "SLRMonthHeaderVM.h"

@interface SLRMonthHeaderVM ()

@property (nonatomic, strong, readonly) NSDateComponents *components;


@end

@implementation SLRMonthHeaderVM

- (instancetype)initWithDateComponents:(NSDateComponents *)components
{
	self = [super init];
	if (self == nil) return nil;

	_components = components;

	return self;
}

- (NSString *)month
{
	return [[[NSCalendar currentCalendar] monthSymbols] objectAtIndex:self.components.month - 1];
}

@end
