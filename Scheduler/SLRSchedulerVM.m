#import "SLRSchedulerVM.h"

#import "SLRIntervalCell.h"
#import "SLRIntervalVM.h"

@interface SLRSchedulerVM ()

@property (nonatomic, strong, readonly) NSMutableArray<SLRIntervalVM *> *intervals;
@property (nonatomic, strong, readonly) RACSubject *didSelectRangeSubject;

@end

@implementation SLRSchedulerVM

- (instancetype)initWithPage:(SLRPage *)page
{
	self = [super init];
	if (self == nil) return nil;

	_didSelectRangeSubject = [RACSubject subject];
	_didSelectRangeSignal = _didSelectRangeSubject;

	NSCAssert(page.timeGrid.bookingStep > 0, @"step should be greather then 0");
	_page = page;

	NSMutableArray<SLRIntervalVM *> *intervals = [NSMutableArray array];
	[page.rangesFree enumerateObjectsUsingBlock:^(SLRRange *freeRange, NSUInteger _, BOOL *__) {
		[intervals addObjectsFromArray:[SLRIntervalVM intervalsForRange:freeRange step:page.timeGrid.bookingStep]];
	}];

	[page.rangesBook enumerateObjectsUsingBlock:^(SLRRange *freeRange, NSUInteger _, BOOL *__) {
		[intervals addObjectsFromArray:[SLRIntervalVM intervalsForRange:freeRange step:page.timeGrid.bookingStep]];
	}];

	[page.rangesHold enumerateObjectsUsingBlock:^(SLRRange *freeRange, NSUInteger _, BOOL *__) {
		[intervals addObjectsFromArray:[SLRIntervalVM intervalsForRange:freeRange step:page.timeGrid.bookingStep]];
	}];

	[intervals enumerateObjectsUsingBlock:^(SLRIntervalVM *intervalVM, NSUInteger idx, BOOL * _Nonnull stop) {
	}];

	[intervals sortWithOptions:NSSortStable usingComparator:^NSComparisonResult(SLRIntervalVM *obj1, SLRIntervalVM *obj2) {
		return obj1.location < obj2.location ? NSOrderedAscending : NSOrderedDescending;
	}];
	_intervals = [intervals copy];
	
	return self;
}

- (void)registerTableView:(UITableView *)tableView
{
	[tableView registerClass:[SLRIntervalCell class] forCellReuseIdentifier:@"cell"];
	tableView.delegate = self;
	tableView.dataSource = self;
}

- (void)didSelectInterval:(SLRIntervalVM *)intervalVM
{
#warning Добавить проверку, что сюда можно попасть - self.page.timeGrid.bookingIntervalMin < чем время до следующего ренджа
	SLRRange *range = [SLRRange rangeWithInterval:intervalVM bookingTime:self.page.timeGrid.bookingIntervalMin];
	[self.didSelectRangeSubject sendNext:range];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.intervals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SLRIntervalCell *cell = (SLRIntervalCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
	cell.intervalVM = [self.intervals objectAtIndex:indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self didSelectInterval:[self.intervals objectAtIndex:indexPath.row]];
}

@end
