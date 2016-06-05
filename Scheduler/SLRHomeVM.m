#import "SLRHomeVM.h"

#import "SLRDataProvider.h"
#import "SLRFilialVM.h"
#import "SLRSchedulerVM.h"

@implementation SLRHomeVM

- (RACSignal *)initialViewModelSignal
{
	return [[[SLRDataProvider sharedProvider] fetchFilials]
		flattenMap:^RACStream *(NSArray<SLRFilial *> *filials) {
			SLRFilial *filial = filials.firstObject;

			if (filial.owners.count > 1)
			{
				return [RACSignal return:[[SLRFilialVM alloc] initWithFilial:filial]];
			}
			else
			{
				SLROwner *owner = filial.owners.firstObject;
				return [[[SLRDataProvider sharedProvider] fetchPagesForOwner:owner date:[NSDate date]]
					map:^SLRSchedulerVM *(NSArray<SLRPage *> *pages) {
						return [[SLRSchedulerVM alloc] initWithPage:pages.firstObject];
					}];
			}
		}];
}

@end
