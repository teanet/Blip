#import "SLROwnersVM.h"

#import "SLROwner.h"
#import "SLROwnerVM.h"

@interface SLROwnersVM () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy, readonly) NSString *ownerCellReuseIdentifier;

@end

@implementation SLROwnersVM

- (instancetype)initWithOwners:(NSArray <SLROwner *> *)owners
{
	self = [super init];
	if (self == nil) return nil;

	@weakify(self);

	_owners = [owners copy];
	_ownerCellReuseIdentifier = NSStringFromClass([SLROwnerVM class]);

	_ownerVMs = [owners.rac_sequence
		map:^SLROwnerVM *(SLROwner *owner) {
			return [[SLROwnerVM alloc] initWithOwner:owner];
		}].array;

	_didSelectOwnerSignal = [[[self rac_signalForSelector:@checkselector(self, didSelectOwnerAtIndexPath:)]
		map:^SLROwner *(RACTuple *tuple) {
			@strongify(self);

			NSIndexPath *indexPath = tuple.first;
			return [self ownerWithIndexPath:indexPath];
		}]
		ignore:nil];

	return self;
}

- (SLROwner *)ownerWithIndexPath:(NSIndexPath *)indexPath
{
	SLROwner *selectedOwner = nil;

	if (indexPath.row < self.owners.count)
	{
		selectedOwner = [self.owners objectAtIndex:indexPath.row];
	}

	return selectedOwner;
}

- (void)didSelectOwnerAtIndexPath:(NSIndexPath *)indexPath
{
}

// MARK: CollectionView

- (void)registerCollectionView:(UICollectionView *)collectionView
{
	collectionView.delegate = self;
	collectionView.dataSource = self;
	[collectionView registerClass:[SLROwnerCell class] forCellWithReuseIdentifier:self.ownerCellReuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.ownerVMs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SLROwnerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.ownerCellReuseIdentifier
																   forIndexPath:indexPath];
	cell.ownerVM = self.ownerVMs[indexPath.item];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	[self didSelectOwnerAtIndexPath:indexPath];
}

@end
