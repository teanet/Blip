#import "SLRLoaderView.h"

@implementation SLRLoaderView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil) return nil;

	self.backgroundColor = [UIColor darkGrayColor];
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[self addSubview:spinner];

	[spinner startAnimating];

	[spinner mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self);
	}];

	return self;
}
@end
