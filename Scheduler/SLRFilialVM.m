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
	SLROwner *owner = [self.filial.owners objectAtIndex:indexPath.row];
	SLRSchedulerVM *schedulerVM = [[SLRSchedulerVM alloc] initWithOwner:owner];
	[self shouldShowScheduler:schedulerVM];
}

- (void)shouldShowScheduler:(SLRSchedulerVM *)viewModel
{
}

@end
