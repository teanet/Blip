#import "SLRSchedulerPagesProvider.h"

#import "SLRDataProvider.h"

@implementation SLRSchedulerPagesProvider

- (RACSignal *)fetchOwnersForPurposes:(NSArray<SLRPurpose *> *)purposes
{
	return [[SLRDataProvider sharedProvider] fetchOwnersForFilial:nil];
}

- (RACSignal *)fetchPageForOwners:(NSArray<SLROwner *> *)owners date:(NSDate *)date
{
	return [[[SLRDataProvider sharedProvider] fetchPagesForOwner:nil]
		map:^SLRPage *(NSArray<SLRPage *> *pages) {
			return pages.firstObject;
		}];
}

@end
