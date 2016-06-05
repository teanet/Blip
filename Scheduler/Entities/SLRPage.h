#import "SLRSerializableProtocol.h"

#import "SLRRange.h"
#import "SLRTimeGrid.h"
#import "SLROwner.h"

@interface SLRPage : NSObject <SLRSerializableProtocol>

/*! Лист календаря расписания.
	Каждый день - новый лист расписания.
 {
	"id" : string,
	"date" : "01-01-2016",
	"ranges_free" : [
		{},
		{},
		...
	],
	"ranges_hold" : [
		{},
		{},
		...
	],
	"ranges_book" : [
		{},
		{},
		...
	]
 }
 */

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, strong, readonly) SLRTimeGrid *timeGrid;
@property (nonatomic, strong, readonly) SLROwner *owner;

/*! @[SLRRange] */
@property (nonatomic, copy, readonly) NSArray<SLRRange *> *rangesFree;
/*! @[SLRRange] */
@property (nonatomic, copy, readonly) NSArray<SLRRange *> *rangesHold;
/*! @[SLRRange] */
@property (nonatomic, copy, readonly) NSArray<SLRRange *> *rangesBook;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong, readonly) NSMutableArray<SLRIntervalVM *> *intervals;

@end

@interface SLRPage (SLRTesting)

+ (SLRPage *)testPage;
+ (SLRPage *)testPageWithDate:(NSString *)dateString;

@end
