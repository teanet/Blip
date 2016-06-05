#import "SLRFilialVM.h"

#import "SLRFilial.h"
#import "SLROwnerVM.h"
#import "SLRSchedulerVM.h"
#import "SLRDataProvider.h"

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
	_shouldShowSchedulerSignal = [[self rac_signalForSelector:@checkselector(self, shouldShowScheduler:)]
		map:^SLRSchedulerVM *(RACTuple *tuple) {
			return tuple.first;
		}];

	return self;
}

- (NSString *)title
{
	return self.filial.title;
}

- (void)didSelectOwnerAtIndexPath:(NSIndexPath *)indexPath
{
	@weakify(self);

	SLROwner *owner = [self.filial.owners objectAtIndex:indexPath.row];
	[[[SLRDataProvider sharedProvider] fetchPagesForOwner:owner date:[NSDate date]]
		subscribeNext:^(NSArray<SLRPage *> *pages) {
			@strongify(self);

			SLRSchedulerVM *schedulerVM = [[SLRSchedulerVM alloc] init];
			schedulerVM.page = pages.firstObject;
			[self shouldShowScheduler:schedulerVM];
		}];
}

- (void)shouldShowScheduler:(SLRSchedulerVM *)viewModel
{
}

@end
