#import "SLRHomeVM.h"

#import "SLRDataProvider.h"
#import "SLRFilialVM.h"
#import "SLRSchedulerVM.h"

@implementation SLRHomeVM

- (RACSignal *)initialViewModelSignal
{
	return [[[SLRDataProvider sharedProvider] fetchFilials]
		map:^SLRBaseVM *(NSArray<SLRFilial *> *filials) {
			SLRBaseVM *returnVM = nil;
			SLRFilial *filial = filials.firstObject;

			if (filial.owners.count > 1)
			{
				returnVM = [[SLRFilialVM alloc] initWithFilial:filial];
			}
			else
			{
				SLROwner *owner = filial.owners.firstObject;
				returnVM = [[SLRSchedulerVM alloc] initWithOwner:owner];
			}

			return returnVM;
		}];
}

@end
