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

	self.contentView.clipsToBounds = NO;
	self.contentView.backgroundColor = [UIColor clearColor];

	_imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
	_imageView.contentMode = UIViewContentModeScaleAspectFill;
	_imageView.clipsToBounds = YES;
	[self.contentView addSubview:_imageView];

	UIView *filterView = [[UIView alloc] init];
	filterView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
	[_imageView addSubview:filterView];

	_titleLabel = [[UILabel alloc] init];
	self.titleLabel.numberOfLines = 0;
	self.titleLabel.textAlignment = NSTextAlignmentLeft;
	self.titleLabel.font = [UIFont systemFontOfSize:12.0];
	self.titleLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:self.titleLabel];

	_subtitleLabel = [[UILabel alloc] init];
	self.subtitleLabel.numberOfLines = 0;
	self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
	self.subtitleLabel.font = [UIFont systemFontOfSize:10.0];
	self.subtitleLabel.textColor = [UIColor lightGrayColor];
	[self.contentView addSubview:self.subtitleLabel];

	[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.contentView);
	}];

	[filterView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.imageView);
	}];

	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.imageView.mas_centerY).with.offset(16.0);
		make.leading.equalTo(self.imageView).with.offset(8.0);
		make.trailing.equalTo(self.imageView).with.offset(-8.0);
	}];

	[self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom);
		make.leading.equalTo(self.titleLabel);
		make.trailing.equalTo(self.titleLabel);
		make.bottom.equalTo(self.contentView).with.offset(-4.0);
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
