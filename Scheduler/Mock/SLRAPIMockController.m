#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRService.h"

#import "SLRAPIMockController.h"

@implementation SLRAPIMockController

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials
{
	return [RACSignal return:@[[SLRFilial testFilial]]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
{
	return [RACSignal return:@[[SLRPage testPage]]];
}

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date
{
	return [RACSignal return:@[[SLRPage testPage]]];
}

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range
{
	return [RACSignal return:[SLRService testServices]];
}

@end
