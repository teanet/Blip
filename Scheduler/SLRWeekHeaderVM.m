#import "SLRWeekHeaderVM.h"

@implementation SLRWeekHeaderVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_pages = @[
		[SLRPage testPageWithDate:@"01-01-2010"],
		[SLRPage testPageWithDate:@"02-01-2010"],
		[SLRPage testPageWithDate:@"03-01-2010"],
		[SLRPage testPageWithDate:@"04-01-2010"],
		[SLRPage testPageWithDate:@"05-01-2010"],
		[SLRPage testPageWithDate:@"06-01-2010"],
		[SLRPage testPageWithDate:@"07-01-2010"],
	];

	return self;
}

- (SLRPage *)selectedPage
{
	__block SLRPage *selectedPage = nil;
	[self.pages enumerateObjectsUsingBlock:^(SLRPage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if (obj.selected)
		{
			selectedPage = obj;
			*stop = YES;
		}
	}];
	return selectedPage;
}

@end
