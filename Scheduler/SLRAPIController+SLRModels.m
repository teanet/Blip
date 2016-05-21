#import "SLRAPIController+SLRModels.h"

#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRService.h"

@implementation SLRAPIController (TKSModels)

// MARK: WebAPI Server

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials
{
#warning Backend required. Переделать на backend.
	return [RACSignal return:@[[SLRFilial testFilial]]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
{
#warning Backend required. Переделать на backend.
	return [RACSignal return:@[[SLRPage testPage]]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date
{
#warning Backend required. Переделать на backend.
	return [RACSignal return:@[[SLRPage testPage]]];
}

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range
{
#warning Backend required. Переделать на backend.
	return [RACSignal return:[SLRService testServices]];
}

@end
