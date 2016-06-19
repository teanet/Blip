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
	return [[self.class monthes] objectAtIndex:self.components.month - 1];
}

+ (NSArray<NSString *> *)monthes
{
	return @[
		@"Январь",
		@"Февраль",
		@"Март",
		@"Апрель",
		@"Май",
		@"Июнь",
		@"Июль",
		@"Август",
		@"Сентябрь",
		@"Октябрь",
		@"Ноябрь",
		@"Декабрь",
	];
}

@end
