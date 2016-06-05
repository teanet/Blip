#import "SLRSchedulerVM.h"

#import "SLRIntervalCell.h"
#import "SLRIntervalVM.h"
#import "SLRWeekHeaderView.h"
#import "SLRDataProvider.h"
#import <TLIndexPathSectionInfo.h>

@interface SLRSchedulerVM () <SLRWeekHeaderViewDelegate>

@property (nonatomic, strong, readonly) SLROwner *owner;
@property (nonatomic, strong, readonly) RACSubject *didSelectRangeSubject;
@property (nonatomic, strong, readonly) RACSubject *didSelectPageSubject;

@property (nonatomic, strong, readonly) NSArray<SLRWeekHeaderVM *> *weekHeaderVMs;

@end

@implementation SLRSchedulerVM

- (void)dealloc
{
	[_didSelectRangeSubject sendCompleted];
	[_didSelectPageSubject sendCompleted];
}

- (instancetype)initWithOwner:(SLROwner *)owner
{
	self = [super init];
	if (self == nil) return nil;

	_owner = owner;
	_title = owner.title;

	_weekHeaderVMs = @[
		[[SLRWeekHeaderVM alloc] init],
		[[SLRWeekHeaderVM alloc] init],
		[[SLRWeekHeaderVM alloc] init],
	];

	_indexPathController = [[TLIndexPathController alloc] init];

	_didSelectRangeSubject = [RACSubject subject];
	_didSelectRangeSignal = _didSelectRangeSubject;

	_didSelectPageSubject = [RACSubject subject];
	_didSelectPageSignal = _didSelectPageSubject;

	[self fetchTodayPage];

	return self;
}

- (void)fetchTodayPage
{
	@weakify(self);

	[[[SLRDataProvider sharedProvider] fetchPagesForOwner:self.owner date:[NSDate date]]
		subscribeNext:^(NSArray<SLRPage *> *pages) {
			@strongify(self);

			self.page = pages.firstObject;
		}];
}

- (void)setPage:(SLRPage *)page
{
	SLRPage *previousPage = _page;
	_page = page;

	NSMutableArray<TLIndexPathSectionInfo *> *infos = [NSMutableArray array];
	[self.weekHeaderVMs enumerateObjectsUsingBlock:^(SLRWeekHeaderVM *weekVM, NSUInteger idx, BOOL * _Nonnull stop) {

		NSArray *items = @[];
		if ([weekVM.pages containsObject:page])
		{
			items = page.intervals;
		}
		[infos addObject:[[TLIndexPathSectionInfo alloc] initWithItems:items name:[@(idx) description]]];
	}];

	self.indexPathController.dataModel = [[TLIndexPathDataModel alloc] initWithSectionInfos:infos identifierKeyPath:nil];
	[self.didSelectPageSubject sendNext:RACTuplePack(page, previousPage)];
}

- (void)registerTableView:(UITableView *)tableView
{
	[tableView registerClass:[SLRIntervalCell class] forCellReuseIdentifier:@"cell"];
	[tableView registerClass:[SLRWeekHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
	tableView.delegate = self;
	tableView.dataSource = self;
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

#pragma mark SLRWeekHeaderViewDelegate

- (void)weekHeaderView:(SLRWeekHeaderView *)weekHeaderView didSelectPage:(SLRPage *)page
{
	if (self.page == page)
	{
		self.page.selected = NO;
		self.page = nil;
	}
	else
	{
		self.page.selected = NO;
		page.selected = YES;
		self.page = page;
	}
}

#pragma mark - UICollectionViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	SLRWeekHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
	headerView.weekVM = self.weekHeaderVMs[section];
	headerView.delegate = self;
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 100.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.weekHeaderVMs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.weekHeaderVMs[section].selectedPage.intervals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SLRIntervalCell *cell = (SLRIntervalCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
	cell.intervalVM = self.weekHeaderVMs[indexPath.section].selectedPage.intervals[indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self didSelectInterval:self.weekHeaderVMs[indexPath.section].selectedPage.intervals[indexPath.row]];
}

@end
