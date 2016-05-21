#import "SLRSchedulerVM.h"

#import "SLRScheduleCell.h"
#import "MSDayColumnHeader.h"
#import "MSTimeRowHeader.h"
#import "MSEventCell.h"
#import "MSGridline.h"

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
	return self;
}

- (void)registerCollectionView:(UICollectionView *)collectionView
{
	collectionView.backgroundColor = [UIColor colorWithWhite:247/255. alpha:1.0];
	[collectionView registerClass:[SLRScheduleCell class] forCellWithReuseIdentifier:@"SLRScheduleCell"];
	collectionView.delegate = self;
	collectionView.dataSource = self;

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
	return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
//	[self selectEmoji:[@(indexPath.row) description]];
}

@end
