#import "SLRSchedulerVM.h"

#import "SLRScheduleCell.h"

@interface SLRSchedulerVM ()

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

	NSMutableArray *scheduleCellVMs = [NSMutableArray array];
	[_model.allIntervals enumerateObjectsUsingBlock:^(id<SLRScheduleInterval> i, NSUInteger idx, BOOL * _Nonnull stop) {
		SLRScheduleCellVM *scheduleCellVM = [[SLRScheduleCellVM alloc] init];
		scheduleCellVM.interval = i;
		[scheduleCellVMs addObject:scheduleCellVM];
	}];
	_scheduleCellVMs = [scheduleCellVMs copy];
	
	return self;
}

#pragma mark cell

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.scheduleCellVMs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SLRScheduleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLRScheduleCell" forIndexPath:indexPath];
	SLRScheduleCellVM *scheduleCellVM = self.scheduleCellVMs[indexPath.item];
	cell.viewModel = scheduleCellVM;
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
//	[self selectEmoji:[@(indexPath.row) description]];
}

@end
