#import "SLRCartVC.h"

#import "SLRStoreItemCell.h"
#import "SLRStoreItemDetailsVC.h"
#import "SLRSchedulerVC.h"
#import "SLRDataProvider.h"

@interface SLRCartVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SLRCartVC

- (instancetype)initWithViewModel:(SLRCartVM *)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.title = @"Cart";

	return self;
}

- (void)viewDidLoad
{
	self.edgesForExtendedLayout = UIRectEdgeNone;

	UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithTitle:@"Order"
																	style:UIBarButtonItemStylePlain
																   target:self
																   action:@selector(didTapOrderButton)];
	self.navigationItem.rightBarButtonItem = orderButton;

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(70.0, 70.0);
	flowLayout.minimumInteritemSpacing = 8.0;
	flowLayout.minimumLineSpacing = 8.0;
	flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
	flowLayout.sectionInset = UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);

	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	self.collectionView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 64.0, 0.0);
	self.collectionView.backgroundColor = [UIColor whiteColor];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[SLRStoreItemCell class] forCellWithReuseIdentifier:@"SLRStoreItemCell"];

	[self.view addSubview:self.collectionView];

	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.viewModel updateItems];
	[self.collectionView reloadData];
}

- (void)didTapOrderButton
{
	@weakify(self);

	[[[SLRDataProvider sharedProvider] fetchPagesForOwner:nil]
		subscribeNext:^(NSArray<SLRPage *> *pages) {
			@strongify(self);
			
			SLRSchedulerVM *vm = [[SLRSchedulerVM alloc] initWithPage:pages.firstObject];
			SLRSchedulerVC *vc = [[SLRSchedulerVC alloc] initWithViewModel:vm];

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
	SLRStoreItemDetailsVM *vm = [[SLRStoreItemDetailsVM alloc] initWithStoreItem:storeItem
																		   style:SLRStoreItemDetailsStyleRemove];
	SLRStoreItemDetailsVC *vc = [[SLRStoreItemDetailsVC alloc] initWithViewModel:vm];
	vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;

	[self presentViewController:vc animated:YES completion:nil];
}

@end
