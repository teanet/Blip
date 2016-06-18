#import "SLRSchedulerPagesProvider.h"

#import "SLRDataProvider.h"

@interface SLRSchedulerPagesProvider ()

@property (nonatomic, copy, readonly) NSArray<SLROwner *> *owners;
@property (nonatomic, copy, readonly) NSArray<SLRPurpose *> *purposes;

@end

@implementation SLRSchedulerPagesProvider

- (instancetype)initWithOwners:(NSArray<SLROwner *> *)owners purposes:(NSArray<SLRPurpose *> *)purposes
{
	self = [super init];
	if (self == nil) return nil;

	_owners = [owners copy];
	_purposes = [purposes copy];

	return self;
}

- (RACSignal *)fetchOwnersForPurposes:(NSArray<SLRPurpose *> *)purposes
{
	return [RACSignal return:self.owners.firstObject];
}

- (RACSignal *)fetchPageForOwners:(NSArray<SLROwner *> *)owners date:(NSDate *)date
{
	return [[SLRDataProvider sharedProvider] fetchPagesForOwner:owners.firstObject date:date];
}

@end
