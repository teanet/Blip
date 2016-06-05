#import "SLROwnerCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SLROwnerCell ()

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subtitleLabel;

@end

@implementation SLROwnerCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	self.contentView.clipsToBounds = YES;
	self.contentView.backgroundColor = [UIColor whiteColor];

	_imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
	_imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.contentView addSubview:_imageView];

	_titleLabel = [[UILabel alloc] init];
	self.titleLabel.numberOfLines = 0;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.titleLabel.font = [UIFont systemFontOfSize:14.0];
	self.titleLabel.textColor = [UIColor blackColor];
	[self.contentView addSubview:self.titleLabel];

	_subtitleLabel = [[UILabel alloc] init];
	self.subtitleLabel.numberOfLines = 0;
	self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
	self.subtitleLabel.font = [UIFont systemFontOfSize:14.0];
	self.titleLabel.textColor = [UIColor grayColor];
	[self.contentView addSubview:self.subtitleLabel];

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
	}];

	[self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom);
		make.left.equalTo(self.imageView);
		make.right.equalTo(self.imageView);
		make.bottom.equalTo(self.contentView).with.offset(-8.0);
	}];

	return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
}

- (void)setOwnerVM:(SLROwnerVM *)ownerVM
{
	_ownerVM = ownerVM;
	[self.imageView setImageWithURL:[NSURL URLWithString:ownerVM.imageURLString]];
	self.titleLabel.text = ownerVM.title;
	self.subtitleLabel.text = ownerVM.subtitle;
}

@end
