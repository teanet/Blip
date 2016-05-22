#import "SLRDetailsVM.h"

#import "SLRDataProvider.h"

@interface SLRDetailsVM ()

@property (nonatomic, strong, readonly) SLRPage *page;
@property (nonatomic, strong, readonly) SLRRange *range;

@end

@implementation SLRDetailsVM

- (instancetype)initWithPage:(SLRPage *)page selectedRange:(SLRRange *)selectedRange
{
	self = [super init];
	if (self == nil) return nil;

	_page = page;
	_range = selectedRange;

	[self setupReactiveStuff];

	return self;
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[[[SLRDataProvider sharedProvider] fetchServicesForPage:self.page range:self.range]
		subscribeNext:^(NSArray<SLRService *> *services) {
			@strongify(self);

			self.range.services = services;
		}];
}

@end
