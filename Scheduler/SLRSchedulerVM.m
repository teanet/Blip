#import "SLRSchedulerVM.h"

#import "SLRScheduleCell.h"
#import "MSDayColumnHeader.h"
#import "MSTimeRowHeader.h"
#import "MSEventCell.h"
#import "MSGridline.h"

NSString * const MSEventCellReuseIdentifier = @"MSEventCellReuseIdentifier";
NSString * const MSDayColumnHeaderReuseIdentifier = @"MSDayColumnHeaderReuseIdentifier";
NSString * const MSTimeRowHeaderReuseIdentifier = @"MSTimeRowHeaderReuseIdentifier";

@interface SLRSchedulerVM () <MSCollectionViewDelegateCalendarLayout>

@property (nonatomic, strong, readonly) SLRScheduleModel *model;
@property (nonatomic, strong, readonly) NSArray<SLRScheduleCellVM *> *scheduleCellVMs;


@end

@implementation SLRSchedulerVM

- (instancetype)initWithModel:(SLRScheduleModel *)model
{
	self = [super init];
	if (self == nil) return nil;

	NSCAssert(model.step > 0, @"step should be greather then 0");
	_model = model;

	_collectionViewCalendarLayout = [[MSCollectionViewCalendarLayout alloc] init];
	_collectionViewCalendarLayout.delegate = self;

	[_collectionViewCalendarLayout registerClass:MSGridline.class forDecorationViewOfKind:MSCollectionElementKindVerticalGridline];
	[_collectionViewCalendarLayout registerClass:MSGridline.class forDecorationViewOfKind:MSCollectionElementKindHorizontalGridline];
	[_collectionViewCalendarLayout registerClass:MSGridline.class forDecorationViewOfKind:MSCollectionElementKindCurrentTimeIndicator];

	NSMutableArray *scheduleCellVMs = [NSMutableArray array];
	[_model.allIntervals enumerateObjectsUsingBlock:^(id<SLRScheduleInterval> i, NSUInteger idx, BOOL * _Nonnull stop) {
		SLRScheduleCellVM *scheduleCellVM = [[SLRScheduleCellVM alloc] init];
		scheduleCellVM.interval = i;
		[scheduleCellVMs addObject:scheduleCellVM];
	}];
	_scheduleCellVMs = [scheduleCellVMs copy];

	return self;
}

- (void)registerCollectionView:(UICollectionView *)collectionView
{
	collectionView.backgroundColor = [UIColor colorWithWhite:247/255. alpha:1.0];
	[collectionView registerClass:[SLRScheduleCell class] forCellWithReuseIdentifier:@"SLRScheduleCell"];
	collectionView.delegate = self;
	collectionView.dataSource = self;
	[collectionView registerClass:MSDayColumnHeader.class forSupplementaryViewOfKind:MSCollectionElementKindDayColumnHeader withReuseIdentifier:MSDayColumnHeaderReuseIdentifier];
	[collectionView registerClass:MSTimeRowHeader.class forSupplementaryViewOfKind:MSCollectionElementKindTimeRowHeader withReuseIdentifier:MSTimeRowHeaderReuseIdentifier];
	[collectionView registerClass:MSEventCell.class forCellWithReuseIdentifier:MSEventCellReuseIdentifier];
	
}

#pragma mark cell

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 1;//2;//self.scheduleCellVMs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MSEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSEventCellReuseIdentifier forIndexPath:indexPath];

	//    cell.event = [self.fetchedResultsController objectAtIndexPath:indexPath];
	return cell;
//
//	SLRScheduleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLRScheduleCell" forIndexPath:indexPath];
//	SLRScheduleCellVM *scheduleCellVM = self.scheduleCellVMs[indexPath.item];
//	cell.viewModel = scheduleCellVM;
//	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	UICollectionReusableView *view;
	if (kind == MSCollectionElementKindDayColumnHeader) {
		MSDayColumnHeader *dayColumnHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MSDayColumnHeaderReuseIdentifier forIndexPath:indexPath];
		NSDate *day = [self.collectionViewCalendarLayout dateForDayColumnHeaderAtIndexPath:indexPath];
		NSDate *currentDay = [self currentTimeComponentsForCollectionView:collectionView layout:self.collectionViewCalendarLayout];

		NSDate *startOfDay = [[NSCalendar currentCalendar] startOfDayForDate:day];
		NSDate *startOfCurrentDay = [[NSCalendar currentCalendar] startOfDayForDate:currentDay];

		dayColumnHeader.day = day;
		dayColumnHeader.currentDay = [startOfDay isEqualToDate:startOfCurrentDay];

		view = dayColumnHeader;
	} else if (kind == MSCollectionElementKindTimeRowHeader) {
		MSTimeRowHeader *timeRowHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MSTimeRowHeaderReuseIdentifier forIndexPath:indexPath];
		timeRowHeader.time = [self.collectionViewCalendarLayout dateForTimeRowHeaderAtIndexPath:indexPath];
		view = timeRowHeader;
	}
	return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
//	[self selectEmoji:[@(indexPath.row) description]];
}

#pragma mark - MSCollectionViewCalendarLayout

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout dayForSection:(NSInteger)section
{
	return [NSDate date];
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout startTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [NSDate date];
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout endTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [[NSDate date] dateByAddingTimeInterval:(60 * 60 * 5 * (indexPath.row + 1))];
}

- (NSDate *)currentTimeComponentsForCollectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout
{
	return [NSDate date];
}

@end
