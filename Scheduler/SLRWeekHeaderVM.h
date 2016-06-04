#import "SLRPage.h"

@interface SLRWeekHeaderVM : NSObject

@property (nonatomic, strong, readonly) NSArray<SLRPage *> *pages;
@property (nonatomic, weak, readonly) SLRPage *selectedPage;

@end
