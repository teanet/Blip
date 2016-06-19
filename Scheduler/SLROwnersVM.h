#import "SLRBaseVM.h"

#import "SLROwnerCell.h"

@class SLROwner;
@class SLROwnerVM;
@class SLRPurpose;

@interface SLROwnersVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLROwner *selectedOwner;
@property (nonatomic, strong, readonly) SLRPurpose *selectedPurpose;
@property (nonatomic, copy, readonly) NSArray <SLROwner *> *owners;
@property (nonatomic, copy, readonly) NSArray<SLROwnerVM *> *ownerVMs;

/*! Сигнал о том, что выбран Owner
 *	\sendNext SLROwner
 **/
@property (nonatomic, strong, readonly) RACSignal *didSelectOwnerSignal;

- (instancetype)initWithOwners:(NSArray <SLROwner *> *)owners selectedPurpose:(SLRPurpose *)purpose;

- (void)registerCollectionView:(UICollectionView *)collectionView;

@end
