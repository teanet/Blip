@class SLROwner;
@class SLRPage;
@class SLRPurpose;

@interface SLRSchedulerPagesProvider : NSObject

/*! Этот объект просто решает вопросы мержа страниц для owner'ов.
 *	Он отдает смерженную страницу для owner'ов, которую мы просто сетим шедулеру.
 **/

/*! Сигнал со всеми owner'ами, которые могут оказать список услуг.
 *	\sendNext @[SLROwner]
 **/
- (RACSignal *)fetchOwnersForPurposes:(NSArray<SLRPurpose *> *)purposes;

/*! Сигнал со смерженной страницей расписаний для всех owner'ов.
 *	\sendNext SLRPage
 **/
- (RACSignal *)fetchPageForOwners:(NSArray<SLROwner *> *)owners date:(NSDate *)date;

@end
