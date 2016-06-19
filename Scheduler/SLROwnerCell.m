#import "SLROwnerCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "SLRDataProvider.h"

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
	_imageView.layer.cornerRadius = 31.0;
	_imageView.layer.borderColor = [UIColor whiteColor].CGColor;
	_imageView.layer.borderWidth = 2.0;
	[self.contentView addSubview:_imageView];

	UIView *filterView = [[UIView alloc] init];
	filterView.backgroundColor = [[SLRDataProvider sharedProvider].projectSettings.navigaitionBarBGColor colorWithAlphaComponent:0.7];
	[_imageView addSubview:filterView];

	_titleLabel = [[UILabel alloc] init];
	self.titleLabel.numberOfLines = 1;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.titleLabel.font = [UIFont systemFontOfSize:16.0];
	self.titleLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:self.titleLabel];

	_subtitleLabel = [[UILabel alloc] init];
	self.subtitleLabel.numberOfLines = 1;
	self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
	self.subtitleLabel.font = [UIFont systemFontOfSize:12.0];
	self.subtitleLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:self.subtitleLabel];

	[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView).with.offset(24.0);
		make.centerX.equalTo(self.contentView);
		make.size.mas_offset(CGSizeMake(62.0, 62.0));
	}];

	[filterView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.imageView);
		make.size.mas_offset(CGSizeMake(62.0, 62.0));
	}];

	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.imageView.mas_bottom).with.offset(3.0);
		make.leading.equalTo(self.contentView).with.offset(8.0);
		make.trailing.equalTo(self.contentView).with.offset(-8.0);
	}];

	[self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom);
		make.leading.equalTo(self.contentView).with.offset(8.0);
		make.trailing.equalTo(self.contentView).with.offset(-8.0);
	}];

	[RACObserve(self, ownerVM.selected)
		subscribeNext:^(NSNumber *selectedNumber) {
			filterView.hidden = selectedNumber.boolValue;
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
