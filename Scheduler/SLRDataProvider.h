#import "SLRFilial.h"
#import "SLROwner.h"
#import "SLRPage.h"

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

@end

NS_ASSUME_NONNULL_END
