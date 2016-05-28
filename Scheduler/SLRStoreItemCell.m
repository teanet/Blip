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

	_imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
	_imageView.contentMode = UIViewContentModeCenter;
	_imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	[self.contentView addSubview:_imageView];

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
	self.titleLabel.text = @"Товар";
}

@end
