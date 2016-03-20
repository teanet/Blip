#import "SLRSchedulerVM.h"

#import "SLRScheduleCell.h"

@implementation SLRSchedulerVM


#pragma mark coll

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 124;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SLRScheduleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLRScheduleCell" forIndexPath:indexPath];
//	cell.imageView.image = [UIImage imageNamed:[@(indexPath.row) description]];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
//	[self selectEmoji:[@(indexPath.row) description]];
}

@end
