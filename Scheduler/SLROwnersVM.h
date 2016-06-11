#import "SLRBaseVM.h"

#import "SLROwnerCell.h"

@class SLROwner;
@class SLROwnerVM;

@interface SLROwnersVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSArray<SLROwnerVM *> *ownerVMs;

/*! Сигнал о том, что выбран Owner
 *	\sendNext SLROwner
 **/
@property (nonatomic, strong, readonly) RACSignal *didSelectOwnerSignal;

- (instancetype)initWithOwners:(NSArray <SLROwner *> *)owners;

- (void)registerCollectionView:(UICollectionView *)collectionView;

@end
