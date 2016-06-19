#import "SLRBaseVM.h"

#import "SLRNews.h"

@interface SLRNewsCellVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *imageURLString;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *dateString;

- (instancetype)initWithNews:(SLRNews *)news;

@end
