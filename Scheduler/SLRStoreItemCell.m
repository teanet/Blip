#import "SLRStoreItemCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SLRStoreItemCell ()

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

@end

@implementation SLRStoreItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	self.contentView.clipsToBounds = YES;
	self.contentView.backgroundColor = [UIColor whiteColor];

	_imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
	_imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.contentView addSubview:_imageView];

	_titleLabel = [[UILabel alloc] init];
	self.titleLabel.numberOfLines = 3;
	self.titleLabel.font = [UIFont systemFontOfSize:14.0];
	[self.contentView addSubview:self.titleLabel];

	UIView *maskView = [[UIView alloc] init];
	maskView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
	[self.contentView addSubview:maskView];

	[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView).with.offset(8.0);
		make.left.equalTo(self.contentView).with.offset(8.0);
		make.right.equalTo(self.contentView).with.offset(-8.0);
		make.height.equalTo(@96.0);
	}];

	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.imageView.mas_bottom).with.offset(8.0);
		make.left.equalTo(self.imageView);
		make.right.equalTo(self.imageView);
		make.bottom.equalTo(self.contentView).with.offset(-8.0);
	}];

	[maskView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel).with.offset(22.0);
		make.left.equalTo(self.titleLabel);
		make.right.equalTo(self.titleLabel);
		make.bottom.equalTo(self.titleLabel);
	}];

	return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
}

- (void)setStoreItem:(SLRStoreItem *)storeItem
{
	_storeItem = storeItem;
	[self.imageView setImageWithURL:[NSURL URLWithString:storeItem.photoSmallURLString]];
	self.titleLabel.text = storeItem.summary;
}

@end
