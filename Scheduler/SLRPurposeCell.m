#import "SLRPurposeCell.h"

@interface SLRPurposeCell ()

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *priceLabel;

@end

@implementation SLRPurposeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	_titleLabel = [[UILabel alloc] init];
	_titleLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	_titleLabel.textAlignment = NSTextAlignmentLeft;
	[self.contentView addSubview:_titleLabel];

	_priceLabel = [[UILabel alloc] init];
	_priceLabel.font = [UIFont dgs_boldDisplayTypeFontOfSize:16.0];
	_priceLabel.textAlignment = NSTextAlignmentRight;
	[self.contentView addSubview:_priceLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.contentView.mas_centerY);
		make.left.equalTo(self.contentView).with.offset(24.0);
		make.right.equalTo(self.priceLabel.mas_left);
	}];

	[_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.contentView.mas_centerY);
		make.right.equalTo(self.contentView).with.offset(-32.0);
	}];

	return self;
}

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	self.titleLabel.text = self.viewModel.title;
	self.priceLabel.text = self.viewModel.price;
}

@end
