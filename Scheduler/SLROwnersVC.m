#import "SLROwnersVC.h"

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
	self.collectionView.contentInset = UIEdgeInsetsMake(-45.0, 0.0, -74.0, 0.0);
	self.collectionView.backgroundColor = [UIColor dgs_colorWithString:@"FBFAF9"];

	[self.view addSubview:self.collectionView];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[self.viewModel registerCollectionView:self.collectionView];
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
