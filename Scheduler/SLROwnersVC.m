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

	UIView *maskView = [[UIView alloc] init];
	maskView.backgroundColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarBGColor;
	[self.view addSubview:maskView];

	[maskView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view).with.offset(90.0);
		make.bottom.equalTo(self.view);
		make.leading.equalTo(self.view);
		make.trailing.equalTo(self.view);
	}];

	UIView *bubbleView = [[UIView alloc] init];
	bubbleView.layer.cornerRadius = 20.0;
	bubbleView.layer.borderColor = [UIColor whiteColor].CGColor;
	bubbleView.layer.borderWidth = 1.0;
	bubbleView.backgroundColor = [UIColor clearColor];
	[maskView addSubview:bubbleView];

	UILabel *bubbleLabel = [[UILabel alloc] init];
	bubbleLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	bubbleLabel.textColor = [UIColor whiteColor];
	bubbleLabel.textAlignment = NSTextAlignmentCenter;
	bubbleLabel.numberOfLines = 1;
	bubbleLabel.text = self.viewModel.selectedPurpose.title;
	[bubbleView addSubview:bubbleLabel];

	[bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@40.0);
		make.centerX.equalTo(maskView);
		make.bottom.equalTo(maskView).with.offset(-10.0);
		make.width.lessThanOrEqualTo(maskView).with.offset(-40.0);
	}];

	[bubbleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(bubbleView);
		make.width.lessThanOrEqualTo(bubbleView).with.offset(-40.0);
	}];

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
