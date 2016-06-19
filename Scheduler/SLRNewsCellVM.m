#import "SLRNewsCellVM.h"

@interface SLRNewsCellVM ()

@property (nonatomic, strong, readonly) SLRNews *news;

@end

@implementation SLRNewsCellVM

- (instancetype)initWithNews:(SLRNews *)news
{
	self = [super init];
	if (self == nil) return nil;

	_news = news;

	return self;
}

- (NSString *)title
{
	return self.news.title;
}

- (NSString *)imageURLString
{
	return self.news.imageURLString;
}

- (NSString *)summary
{
	return self.news.summary;
}

- (NSString *)dateString
{
	return self.news.dateString;
}

@end
