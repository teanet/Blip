#import "SLRFilialOwnersView.h"

#import "SLROwnersVC.h"
#import "UIViewController+DGSAdditions.h"

@interface SLRFilialOwnersView ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SLRFilialOwnersView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	UICollectionViewFlowLayout *flowLayout = [self flowLayout];
	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
	self.collectionView.backgroundColor = [UIColor grayColor];

	[self.contentView addSubview:self.collectionView];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.contentView);
	}];

	return self;
}

- (void)setViewModel:(SLROwnersVM *)viewModel
{
	[viewModel registerCollectionView:self.collectionView];
	[self.collectionView reloadData];
}

- (UICollectionViewFlowLayout *)flowLayout
{
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(120.0, 70.0);
	flowLayout.minimumInteritemSpacing = 0.0;
	flowLayout.minimumLineSpacing = 0.0;
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);

	return flowLayout;
}

@end
