#import "SLRBaseVM.h"

#import "SLRPurpose.h"

@interface SLRPurposeCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

- (instancetype)initWithPurpose:(SLRPurpose *)purpose;

@end
