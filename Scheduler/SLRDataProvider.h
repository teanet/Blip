#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"
#import "SLRService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLRDataProvider : NSObject

+ (instancetype)sharedProvider;

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

NS_ASSUME_NONNULL_END
