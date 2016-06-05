#import "SLRFilialVC.h"

#import "SLROwnerCell.h"
#import "SLROwnerVM.h"
#import "SLRSchedulerVC.h"

// Технический долг =)
@interface SLRFilialVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SLRFilialVC

- (instancetype)initWithViewModel:(id)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = self.viewModel.title;

	return self;
}

- (void)viewDidLoad
{
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(136.0, 176.0);
	flowLayout.minimumInteritemSpacing = 16.0;
	flowLayout.minimumLineSpacing = 16.0;
	flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
	flowLayout.sectionInset = UIEdgeInsetsMake(16.0, 16.0, 16.0, 16.0);

	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	self.collectionView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 64.0, 0.0);
	self.collectionView.backgroundColor = [UIColor dgs_colorWithString:@"FBFAF9"];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[SLROwnerCell class] forCellWithReuseIdentifier:@"SLROwnerCell"];

	[self.view addSubview:self.collectionView];

	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[self setupReactiveStuff];
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[self.viewModel.shouldShowSchedulerSignal
		subscribeNext:^(SLRSchedulerVM *viewModel) {
			@strongify(self);

			SLRSchedulerVC *vc = [[SLRSchedulerVC alloc] initWithViewModel:viewModel];
			[self.navigationController pushViewController:vc animated:YES];
		}];
}

// MARK: UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.viewModel.ownerVMs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SLROwnerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLROwnerCell" forIndexPath:indexPath];
	cell.ownerVM = self.viewModel.ownerVMs[indexPath.item];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	[self.viewModel didSelectOwnerAtIndexPath:indexPath];
}

@end
