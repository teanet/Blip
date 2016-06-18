#import "SLRFilialSchedulerVM.h"

#import "SLROwnersVM.h"
#import "SLROwner.h"
#import "SLRPurpose.h"
#import "SLRSchedulerPagesProvider.h"
#import "SLRSchedulerVM.h"

@interface SLRFilialSchedulerVM ()

@property (nonatomic, strong, readonly) SLRSchedulerPagesProvider *pagesProvider;
@property (nonatomic, strong) SLROwnersVM *ownersVM;
@property (nonatomic, strong) SLRSchedulerVM *schedulerVM;
@property (nonatomic, copy, readonly) NSArray <SLRPurpose *> *purposes;
@property (nonatomic, copy, readonly) NSArray <SLROwner *> *owners;

@end

@implementation SLRFilialSchedulerVM

- (instancetype)initWithPurposes:(NSArray<SLRPurpose *> *)purposes owners:(NSArray<SLROwner *> *)owners
{
	self = [super init];
	if (self == nil) return nil;

	_purposes = [purposes copy];
	_owners = [owners copy];

	_pagesProvider = [[SLRSchedulerPagesProvider alloc] initWithOwners:owners purposes:purposes];

	_schedulerVM = [[SLRSchedulerVM alloc] init];
	_ownersVM = [[SLROwnersVM alloc] initWithOwners:owners];

	[self setupReactiveStuff];

	return self;
}

- (void)setupReactiveStuff
{
	@weakify(self);

	NSDate *dateToday = [NSDate date];
	[[self.pagesProvider fetchPageForOwners:self.owners date:dateToday]
		subscribeNext:^(SLRPage	*page) {
			@strongify(self);

			[self.schedulerVM setPage:page forDate:dateToday];
		}];

	[[self.schedulerVM.didSelectDateSignal
		flattenMap:^RACStream *(NSDate *date) {
			@strongify(self);

			return [[self.pagesProvider fetchPageForOwners:self.owners date:date]
				zipWith:[RACSignal return:date]];
		}]
		subscribeNext:^(RACTuple *t) {
			RACTupleUnpack(SLRPage *page, NSDate *date) = t;
			[self.schedulerVM setPage:page forDate:date];
		}];
}

- (BOOL)shouldShowOwnersPicker
{
	return self.ownersVM.ownerVMs.count > 1;
}

@end
