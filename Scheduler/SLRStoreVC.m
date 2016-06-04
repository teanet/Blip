#import "SLRStoreVC.h"

#import "SLRStoreItemCell.h"
#import "SLRStoreItemDetailsVC.h"
#import "UIColor+DGSCustomColor.h"

@interface SLRStoreVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SLRStoreVC

- (instancetype)initWithViewModel:(SLRStoreVM *)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = @"Store";
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Store"
													image:[UIImage imageNamed:@"shop"]
													  tag:0];

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
	[self.collectionView registerClass:[SLRStoreItemCell class] forCellWithReuseIdentifier:@"SLRStoreItemCell"];

	[self.view addSubview:self.collectionView];

	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[self setupReactiveStuff];
}

- (void)setupReactiveStuff
{
	@weakify(self);

	[[[RACObserve(self.viewModel, storeItems)
		ignore:nil]
		deliverOnMainThread]
		subscribeNext:^(id x) {
			@strongify(self);

			[self.collectionView reloadData];
		}];
}

// MARK: UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.viewModel.storeItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SLRStoreItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLRStoreItemCell" forIndexPath:indexPath];
	cell.storeItem = self.viewModel.storeItems[indexPath.item];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	[self showDetailsForSelectedItem:[self.viewModel.storeItems objectAtIndex:indexPath.row]];
}

- (void)showDetailsForSelectedItem:(SLRStoreItem *)storeItem
{
	SLRStoreItemDetailsVM *vm = [[SLRStoreItemDetailsVM alloc] initWithStoreItem:storeItem style:SLRStoreItemDetailsStyleAdd];
	SLRStoreItemDetailsVC *vc = [[SLRStoreItemDetailsVC alloc] initWithViewModel:vm];
	vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;

	[self presentViewController:vc animated:YES completion:nil];
}

@end
