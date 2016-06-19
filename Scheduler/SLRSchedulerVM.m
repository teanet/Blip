#import "SLRSchedulerVM.h"

#import "SLRIntervalCell.h"
#import "SLRIntervalVM.h"
#import "SLRMonthHeaderView.h"
#import "SLRWeekHeaderView.h"
#import "SLRDataProvider.h"
#import "SLRWeekDayVM.h"
#import <TLIndexPathSectionInfo.h>

static NSTimeInterval kSecondsInWeek = 604800.0;

@interface SLRSchedulerVM ()
<
SLRWeekHeaderViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) SLRWeekDayVM *selectedDayVM;
@property (nonatomic, strong, readonly) SLROwner *owner;
@property (nonatomic, strong, readonly) RACSubject *didSelectRangeSubject;
@property (nonatomic, strong, readonly) RACSubject *didSelectPageSubject;
@property (nonatomic, strong, readonly) RACSubject *didSelectDateSubject;
@property (nonatomic, strong, readonly) NSCalendar *calendar;

@property (nonatomic, strong, readonly) NSArray<SLRBaseVM *> *headerVMs;

@end

@implementation SLRSchedulerVM

- (void)dealloc
{
	[_didSelectRangeSubject sendCompleted];
	[_didSelectPageSubject sendCompleted];
	[_didSelectDateSubject sendCompleted];
}

- (instancetype)init
{
	return [self initWithWeeksCountSinceNow:12];
}

- (instancetype)initWithWeeksCountSinceNow:(NSInteger)weeksCount
{
	self = [super init];
	if (self == nil) return nil;

	_calendar = [NSCalendar currentCalendar];
	[_calendar setFirstWeekday:2];
	[_calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	
	_indexPathController = [[TLIndexPathController alloc] init];

	_didSelectRangeSubject = [RACSubject subject];
	_didSelectRangeSignal = _didSelectRangeSubject;

	_didSelectPageSubject = [RACSubject subject];
	_didSelectPageSignal = _didSelectPageSubject;

	_didSelectDateSubject = [RACSubject subject];
	_didSelectDateSignal = _didSelectDateSubject;

	[self createCalendarHeadersWithWeeksCount:weeksCount];

	return self;
}

- (void)createCalendarHeadersWithWeeksCount:(NSInteger)weeksCount
{
	// Здесь мы создаём хедэры для календаря:
	// Хедер для месяца:
	// -------------------
	// Июнь			  2016
	// -------------------
	// 27 28 29 30 [1 2 3]
	// -------------------
	// Июль			  2016
	// [27 28 29 30] 1 2 3
	// 4  5  6  7  8  9 10

	// Create weeks
	NSArray<NSDate *> *weekDatesArray = [self weekStartDatesSinceNowForWeeksCount:weeksCount];
	_headerVMs = [self weekVMsForWeekStartDates:weekDatesArray];
}

- (NSArray<SLRBaseVM *> *)weekVMsForWeekStartDates:(NSArray<NSDate *> *)startDates
{
	NSMutableArray<SLRBaseVM *> *schedulerHeaderVMs = [[NSMutableArray alloc] init];

	// Create first Month header
	NSDate *firstMonthDate = startDates.firstObject;
	NSDateComponents *firstMonthDateComponents = [self.calendar components:NSCalendarUnitMonth | NSCalendarUnitYear
																  fromDate:firstMonthDate];
	[schedulerHeaderVMs addObject:[[SLRMonthHeaderVM alloc] initWithDateComponents:firstMonthDateComponents]];

	__block NSInteger lastMonth = firstMonthDateComponents.month;

	[startDates enumerateObjectsUsingBlock:^(NSDate *date, NSUInteger idx, BOOL *stop) {

		NSDateComponents *startDateComponents = [self.calendar components:NSCalendarUnitMonth | NSCalendarUnitYear
																 fromDate:date];
		NSDate *endWeekDate = [date dateByAddingTimeInterval:kSecondsInWeek - 1.0];
		NSDateComponents *endDateComponents = [self.calendar components:NSCalendarUnitMonth | NSCalendarUnitYear
															   fromDate:endWeekDate];

		// Добавляем неделю если она фигурирует в старом месяце
		if (lastMonth == startDateComponents.month)
		{
			[schedulerHeaderVMs addObject:[[SLRWeekHeaderVM alloc] initWithStartDate:date month:startDateComponents.month]];
		}

		// Если сменился месяц, то добавляем месяц и неделю
		if (lastMonth != endDateComponents.month)
		{
			[schedulerHeaderVMs addObject:[[SLRMonthHeaderVM alloc] initWithDateComponents:endDateComponents]];
			[schedulerHeaderVMs addObject:[[SLRWeekHeaderVM alloc] initWithStartDate:date month:endDateComponents.month]];
			lastMonth = endDateComponents.month;
		}
	}];

	return [schedulerHeaderVMs copy];
}

- (NSArray<NSDate *> *)weekStartDatesSinceNowForWeeksCount:(NSInteger)weeksCount
{
	NSMutableArray<NSDate *> *weekDatesArray = [[NSMutableArray alloc] initWithCapacity:weeksCount];
	NSDate *now = [NSDate date];

	NSDate *startOfTheWeek;
	NSDate *endOfWeek;
	NSTimeInterval interval;

	for (NSUInteger week = 0; week < weeksCount; week++)
	{
		NSDate *periodicDate = [now dateByAddingTimeInterval:week * kSecondsInWeek];
		[self.calendar rangeOfUnit:NSCalendarUnitWeekOfMonth
						 startDate:&startOfTheWeek
						  interval:&interval
						   forDate:periodicDate];

		endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
		NSDate *startWeekDate = [startOfTheWeek copy];
		[weekDatesArray addObject:startWeekDate];
	}

	return [weekDatesArray copy];
}

- (void)registerTableView:(UITableView *)tableView
{
	[tableView registerClass:[SLRIntervalCell class] forCellReuseIdentifier:@"cell"];
	[tableView registerClass:[SLRWeekHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLRWeekHeaderVM class])];
	[tableView registerClass:[SLRMonthHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLRMonthHeaderVM class])];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.layoutMargins = UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0);
}

- (void)didSelectInterval:(SLRIntervalVM *)intervalVM
{
	if ([self canBookIntervalInCurrentRange:intervalVM])
	{
		SLRRange *range = [SLRRange rangeWithInterval:intervalVM bookingTime:self.page.timeGrid.bookingIntervalMin];
		[self.didSelectRangeSubject sendNext:range];
	}
}

- (BOOL)canBookIntervalInCurrentRange:(SLRIntervalVM *)intervalVM
{
	__block BOOL canBook = NO;
	[self.page.rangesFree enumerateObjectsUsingBlock:^(SLRRange *range, NSUInteger _, BOOL *stop) {
		if ((range.location <= intervalVM.location) &&
			(range.location + range.length > intervalVM.location))
		{
			NSTimeInterval lastAvailableTimeInRange = range.location + range.length;
			canBook = (lastAvailableTimeInRange >= (intervalVM.location + self.page.timeGrid.bookingIntervalMin));
			*stop = YES;
		}
	}];

	return canBook;
}

- (void)setPage:(SLRPage *)page forDate:(NSDate *)date
{
	NSDate *reducedDate = [self reducedDateFromDate:date];
	_selectedDate = reducedDate;

	[self.headerVMs enumerateObjectsUsingBlock:^(SLRBaseVM *baseVM, NSUInteger idx, BOOL *stop) {
		if ([baseVM isKindOfClass:[SLRWeekHeaderVM class]])
		{
			SLRWeekHeaderVM *weekVM = (SLRWeekHeaderVM *)baseVM;
			[weekVM.dayVMs enumerateObjectsUsingBlock:^(SLRWeekDayVM *day, NSUInteger _, BOOL *stop) {
				NSDate *dayReducedDate = [self reducedDateFromDate:day.date];
				if ([dayReducedDate isEqualToDate:reducedDate] && day.interactive)
				{
					self.selectedDayVM = day;
					self.selectedDayVM.selected = YES;
					self.page = page;
					*stop = YES;
				}
			}];
		}
	}];
}

- (NSDate *)reducedDateFromDate:(NSDate *)date
{
	NSCalendarUnit units = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
	NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:date];
	NSDate *reducedDate = [[NSCalendar currentCalendar] dateFromComponents:components];

	return reducedDate;
}

- (void)setPage:(SLRPage *)page
{
	SLRPage *previousPage = _page;
	_page = page;

	NSMutableArray<TLIndexPathSectionInfo *> *infos = [NSMutableArray array];
	[self.headerVMs enumerateObjectsUsingBlock:^(SLRBaseVM *baseVM, NSUInteger idx, BOOL *stop) {
		NSArray *items = @[];
		if ([baseVM isKindOfClass:[SLRWeekHeaderVM class]])
		{
			SLRWeekHeaderVM *weekVM = (SLRWeekHeaderVM *)baseVM;
			if ([weekVM.dayVMs containsObject:self.selectedDayVM])
			{
				items = page.intervals;
				weekVM.selectedPage = page;
			}
			else
			{
				weekVM.selectedPage = nil;
			}
		}
		[infos addObject:[[TLIndexPathSectionInfo alloc] initWithItems:items name:[@(idx) description]]];
	}];

	self.indexPathController.dataModel = [[TLIndexPathDataModel alloc] initWithSectionInfos:infos
																		  identifierKeyPath:nil];
	[self.didSelectPageSubject sendNext:RACTuplePack(page, previousPage)];
}

#pragma mark SLRWeekHeaderViewDelegate

- (void)weekHeaderView:(SLRWeekHeaderView *)weekHeaderView didSelectDay:(SLRWeekDayVM *)dayVM
{
	if (self.selectedDayVM == dayVM)
	{
		self.selectedDayVM.selected = NO;
		self.page = nil;
		self.selectedDayVM = nil;
	}
	else
	{
		self.selectedDayVM.selected = NO;
		dayVM.selected = YES;
		self.selectedDayVM = dayVM;

		[self.didSelectDateSubject sendNext:dayVM.date];
	}
}

#pragma mark - UICollectionViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	SLRBaseVM *headerVM = self.headerVMs[section];
	SLRTableViewHeaderFooterView *headerView =
		[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([headerVM class])];
	headerView.viewModel = headerVM;

	if ([headerView isKindOfClass:[SLRWeekHeaderView class]])
	{
		SLRWeekHeaderView *weekHeaderView = (SLRWeekHeaderView *)headerView;
		weekHeaderView.delegate = self;
	}

	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 60.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.headerVMs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSUInteger rows = 0;
	SLRBaseVM *baseVM = self.headerVMs[section];

	if ([baseVM isKindOfClass:[SLRWeekHeaderVM class]])
	{
		SLRWeekHeaderVM *weekHeaderVM = (SLRWeekHeaderVM *)baseVM;
		rows = weekHeaderVM.selectedPage.intervals.count;
	}

	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SLRIntervalCell *cell = (SLRIntervalCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
	SLRBaseVM *baseVM = self.headerVMs[indexPath.section];

	if ([baseVM isKindOfClass:[SLRWeekHeaderVM class]])
	{
		SLRWeekHeaderVM *weekHeaderVM = (SLRWeekHeaderVM *)baseVM;
		cell.intervalVM = weekHeaderVM.selectedPage.intervals[indexPath.row];
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	SLRBaseVM *baseVM = self.headerVMs[indexPath.section];

	if ([baseVM isKindOfClass:[SLRWeekHeaderVM class]])
	{
		SLRWeekHeaderVM *weekHeaderVM = (SLRWeekHeaderVM *)baseVM;
		[self didSelectInterval:weekHeaderVM.selectedPage.intervals[indexPath.row]];
	}
}

@end
