#import "SLRSchedulerVC.h"

#import "SLRScheduleCell.h"

@interface SLRSchedulerVC ()

@property (nonatomic, strong, readonly) UICollectionView *scheduleView;

@end

@implementation SLRSchedulerVC

@dynamic viewModel;

- (void)viewDidLoad
{
    [super viewDidLoad];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(40.0, 300.0);
	flowLayout.minimumInteritemSpacing = 35.0;
	flowLayout.minimumLineSpacing = 2.0;
	flowLayout.sectionInset = UIEdgeInsetsMake(28.0, 17.0, 8.0, 17.0);
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	_scheduleView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	_scheduleView.delegate = self.viewModel;
	_scheduleView.dataSource = self.viewModel;
	_scheduleView.backgroundColor = [UIColor colorWithWhite:247/255. alpha:1.0];
	[_scheduleView registerClass:[SLRScheduleCell class] forCellWithReuseIdentifier:@"SLRScheduleCell"];
	[self.view addSubview:_scheduleView];
	[_scheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

}

@end
