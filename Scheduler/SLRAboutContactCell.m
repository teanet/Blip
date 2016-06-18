#import "SLRAboutContactCell.h"

@interface SLRAboutContactCell ()

@property (nonatomic, strong, readonly) UIImageView *pinImageView;
@property (nonatomic, strong, readonly) UILabel *addressLabel;

@end

@implementation SLRAboutContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	_addressLabel = [[UILabel alloc] init];
	_addressLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	_addressLabel.textAlignment = NSTextAlignmentCenter;
	_addressLabel.numberOfLines = 2;
	[self addSubview:_addressLabel];

	_pinImageView = [[UIImageView alloc] init];
	UIImage *pinImage = [UIImage imageNamed:@"pinBlue"];
	_pinImageView.image = pinImage;
	[self addSubview:_pinImageView];

	[_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self);
		make.width.lessThanOrEqualTo(self).with.offset(-64.0);
	}];

	[_pinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.trailing.equalTo(_addressLabel.mas_leading).with.offset(-8.0);
		make.centerY.equalTo(_addressLabel);
	}];

	return self;
}

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	self.addressLabel.text = self.viewModel.address;
}

@end
