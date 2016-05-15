#import "SLRSeporatorView.h"

@interface SLRSeporatorView ()

@property (nonatomic, strong, readonly) UILabel *label;

@end

@implementation SLRSeporatorView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil) return nil;

	_label = [[UILabel alloc] init];
	[self addSubview:_label];

	UIView *seporator = [[UIView alloc] init];
	seporator.backgroundColor = [UIColor blackColor];
	[self addSubview:seporator];

	[_label mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(self);
		make.top.equalTo(self);
		make.bottom.equalTo(self);
	}];

	[seporator mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(_label.mas_trailing);
		make.centerY.equalTo(self);
		make.height.equalTo(@(1.0 / [UIScreen mainScreen].scale));
		make.trailing.equalTo(self);
	}];

	return self;
}

- (void)setText:(NSString *)text
{
	_text = text;
	self.label.text = text;
}

@end
