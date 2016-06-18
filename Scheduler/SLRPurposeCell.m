#import "SLRPurposeCell.h"

@interface SLRPurposeCell ()

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subtitleLabel;

@end

@implementation SLRPurposeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	_titleLabel = [[UILabel alloc] init];
	[self.contentView addSubview:_titleLabel];

	_subtitleLabel = [[UILabel alloc] init];
	[self.contentView addSubview:_subtitleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.contentView.mas_centerY);
		make.width.equalTo(self.contentView);
	}];

	[_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView.mas_centerY);
		make.width.equalTo(self.contentView);
	}];

	return self;
}

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	self.titleLabel.text = self.viewModel.title;
	self.subtitleLabel.text = self.viewModel.subtitle;
}

@end
