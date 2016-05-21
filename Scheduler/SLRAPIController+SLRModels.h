#import "SLRAPIController.h"

@class SLROwner;

@interface SLRAPIController (SLRModels)

/*! \return @[SLRFilial] */
- (RACSignal *)fetchFilials;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner;

/*! \return @[SLRPage] */
- (RACSignal *)fetchPagesForOwner:(SLROwner *)owner
							 date:(NSDate *)date;

@end
