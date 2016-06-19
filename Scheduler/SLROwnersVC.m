#import "SLROwnersVC.h"

#import "SLRDataProvider.h"

@interface SLROwnersVC ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SLROwnersVC

- (void)viewDidLoad
{
	[super viewDidLoad];

	UICollectionViewFlowLayout *flowLayout = [self flowLayout];
	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.contentInset = UIEdgeInsetsMake(-45.0, 0.0, -30.0, 0.0);
	self.collectionView.backgroundColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarBGColor;

	[self.view addSubview:self.collectionView];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[self.viewModel registerCollectionView:self.collectionView];
}

- (UICollectionViewFlowLayout *)flowLayout
{
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(84.0, 151.0);
	flowLayout.minimumInteritemSpacing = 0.0;
	flowLayout.minimumLineSpacing = 0.0;
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 12.0, 0.0, 12.0);

	return flowLayout;
}

@end
