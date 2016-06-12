#import "SLRFilialSchedulerVM.h"

#import "SLROwnersVM.h"
#import "SLRPurpose.h"
#import "SLRSchedulerPagesProvider.h"
#import "SLRSchedulerVM.h"

@interface SLRFilialSchedulerVM ()

@property (nonatomic, strong, readonly) SLRSchedulerPagesProvider *pagesProvider;
@property (nonatomic, strong) SLROwnersVM *ownersVM;
@property (nonatomic, strong) SLRSchedulerVM *schedulerVM;
@property (nonatomic, copy, readonly) NSArray <SLRPurpose *> *purposes;


@end

@implementation SLRFilialSchedulerVM

- (instancetype)initWithPurposes:(NSArray <SLRPurpose *> *)purposes
{
	self = [super init];
	if (self == nil) return nil;

	_purposes = [purposes copy];
	_pagesProvider = [[SLRSchedulerPagesProvider alloc] init];
	[self setupReactiveStuff];

	return self;
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[[[self.pagesProvider fetchOwnersForPurposes:self.purposes]
		flattenMap:^RACStream *(NSArray <SLROwner *> *owners) {
			@strongify(self);

			self.ownersVM = [[SLROwnersVM alloc] initWithOwners:owners];
			return [self.pagesProvider fetchPageForOwners:owners date:[NSDate date]];
		}]
		subscribeNext:^(SLRPage *page) {
			self.schedulerVM.page = page;
		}];
}

- (BOOL)shouldShowOwnersPicker
{
	return self.ownersVM.ownerVMs.count > 1;
}

@end
