#import "SLRAPIController+SLRModels.h"

#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"

@implementation SLRAPIController (TKSModels)

// MARK: WebAPI Server

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials
{
#warning Backend required. Переделать на backend.
	return [RACSignal return:@[[SLRFilial filialTest]]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
{
#warning Backend required. Переделать на backend.
	return [RACSignal return:@[[SLRPage pageTest]]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date
{
#warning Backend required. Переделать на backend.
	return [RACSignal return:@[[SLRPage pageTest]]];
}

@end
