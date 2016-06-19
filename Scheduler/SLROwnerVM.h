#import "SLRBaseVM.h"

#import "SLROwner.h"

@interface SLROwnerVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *imageURLString;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithOwner:(SLROwner *)owner selected:(BOOL)selected;

@end
