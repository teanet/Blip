#import "SLRBaseVM.h"

#import "SLRPurpose.h"

@interface SLRPurposeCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;

- (instancetype)initWithPurpose:(SLRPurpose *)purpose;

@end
