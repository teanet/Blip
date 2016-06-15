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
	_schedulerVM = [[SLRSchedulerVM alloc] init];
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
			NSDate *date = [NSDate date];
			return [[self.pagesProvider fetchPageForOwners:owners date:date]
				zipWith:[RACSignal return:date]];
		}]
		subscribeNext:^(RACTuple *t) {
			RACTupleUnpack(SLRPage *page, NSDate *date) = t;
			[self.schedulerVM setPage:page forDate:date];
		}];

	[[self.schedulerVM.didSelectDateSignal
		flattenMap:^RACStream *(NSDate *date) {
			@strongify(self);

			return [[self.pagesProvider fetchPageForOwners:self.ownersVM.owners date:date]
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
