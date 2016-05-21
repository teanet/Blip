#import "SLRAPIController.h"

@class SLROwner;
@class SLRPage;
@class SLRRange;

@interface SLRAPIController (SLRModels)

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date;

/*! \return @[SLRService] */
- (RACSignal *)fetchServicesForPage:(SLRPage *)page
							  range:(SLRRange *)range;

@end
