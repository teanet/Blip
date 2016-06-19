#import "SLRAboutContactCell.h"

#import "SLRMapView.h"

@interface SLRAboutContactCell ()

@property (nonatomic, strong, readonly) UIImageView *pinImageView;
@property (nonatomic, strong, readonly) UILabel *addressLabel;
@property (nonatomic, strong, readonly) SLRMapView *mapView;

@end

@implementation SLRAboutContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.clipsToBounds = YES;

	_addressLabel = [[UILabel alloc] init];
	_addressLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	_addressLabel.textAlignment = NSTextAlignmentCenter;
	_addressLabel.numberOfLines = 2;
	[self.contentView addSubview:_addressLabel];

	_pinImageView = [[UIImageView alloc] init];
	UIImage *pinImage = [UIImage imageNamed:@"pinBlue"];
	_pinImageView.image = pinImage;
	[self.contentView addSubview:_pinImageView];

	UIView *bgColorView = [[UIView alloc] init];
	bgColorView.backgroundColor = [UIColor clearColor];
	[self setSelectedBackgroundView:bgColorView];

	_mapView = [[SLRMapView alloc] initWithFrame:CGRectZero];
	[self addSubview:_mapView];
	[_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self).with.offset(70.0);
		make.centerX.equalTo(self);
		make.width.equalTo(self);
		make.bottom.equalTo(self);
	}];

	[_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self).with.offset(23.0);
		make.centerX.equalTo(self);
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
	self.mapView.viewModel = self.viewModel.mapVM;
}

@end
