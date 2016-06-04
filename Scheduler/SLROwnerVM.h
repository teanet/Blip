#import "SLRBaseVM.h"

#import "SLROwner.h"

@interface SLROwnerVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *imageURLString;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

- (instancetype)initWithOwner:(SLROwner *)owner;

@end
