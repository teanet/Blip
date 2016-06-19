#import "SLRAppointmentCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SLRAppointmentCell ()

@property (nonatomic, strong, readonly) UIImageView *masterImageView;
@property (nonatomic, strong, readonly) UILabel *dateDayLabel;
@property (nonatomic, strong, readonly) UILabel *dateMonthLabel;
@property (nonatomic, strong, readonly) UILabel *serviceTitleLabel;
@property (nonatomic, strong, readonly) UIImageView *pinImageView;
@property (nonatomic, strong, readonly) UILabel *addressLabel;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@property (nonatomic, strong, readonly) UIImageView *markerImageView;

@end

@implementation SLRAppointmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	_masterImageView = [[UIImageView alloc] init];
	_masterImageView.contentMode = UIViewContentModeScaleAspectFill;
	_masterImageView.clipsToBounds = YES;
	_masterImageView.layer.cornerRadius = 30.0;
	[self.contentView addSubview:_masterImageView];

	_dateDayLabel = [[UILabel alloc] init];
	_dateDayLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:40.0];
	[self.contentView addSubview:_dateDayLabel];

	_dateMonthLabel = [[UILabel alloc] init];
	_dateMonthLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:14.0];
	[self.contentView addSubview:_dateMonthLabel];

	_serviceTitleLabel = [[UILabel alloc] init];
	_serviceTitleLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	[self.contentView addSubview:_serviceTitleLabel];

	_pinImageView = [[UIImageView alloc] init];
	_pinImageView.image = [UIImage imageNamed:@"pinGray"];
	[self.contentView addSubview:_pinImageView];

	_addressLabel = [[UILabel alloc] init];
	_addressLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:14.0];
	_addressLabel.textColor = [UIColor grayColor];
	[self.contentView addSubview:_addressLabel];

	_timeLabel = [[UILabel alloc] init];
	_timeLabel.font = [UIFont dgs_boldDisplayTypeFontOfSize:16.0];
	[self.contentView addSubview:_timeLabel];

	_markerImageView = [[UIImageView alloc] init];
	[self.contentView addSubview:_markerImageView];

	[_masterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.contentView);
		make.leading.equalTo(self.contentView.mas_leading).with.offset(68.0);
		make.size.mas_equalTo(CGSizeMake(60.0, 60.0));
	}];

	[_dateDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(self.contentView).with.offset(24.0);
		make.top.equalTo(self.contentView).with.offset(15.0);
	}];

	[_dateMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(_dateDayLabel);
		make.top.equalTo(_dateDayLabel.mas_bottom);
	}];

	[_serviceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(_masterImageView.mas_trailing).with.offset(27.0);
		make.centerY.equalTo(self.contentView).with.offset(-3.0);
		make.trailing.equalTo(self.contentView).with.offset(-15.0);
	}];

	[_pinImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
	[_pinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(_serviceTitleLabel);
		make.top.equalTo(_serviceTitleLabel.mas_bottom).with.offset(3.0);
	}];

	[_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(_pinImageView.mas_trailing).with.offset(3.0);
		make.bottom.equalTo(_pinImageView).with.offset(3.0);
		make.trailing.lessThanOrEqualTo(self.contentView).with.offset(-15.0);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(_serviceTitleLabel);
		make.bottom.equalTo(_serviceTitleLabel.mas_top);
		make.trailing.lessThanOrEqualTo(self.contentView).with.offset(-15.0);
	}];

	[_markerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_masterImageView);
		make.centerX.equalTo(_masterImageView).with.offset(30.0);
	}];

	return self;
}

- (void)setViewModel:(SLRAppointmentCellVM *)viewModel
{
	[super setViewModel:viewModel];

	NSURL *url = [[NSURL alloc] initWithString:self.viewModel.request.masterImageURLString];
	[self.masterImageView setImageWithURL:url];

	self.dateDayLabel.text = [self numberFromDateString:self.viewModel.request.dateString];
	self.dateMonthLabel.text = [self secondFromDateString:self.viewModel.request.dateString];
	self.serviceTitleLabel.text = self.viewModel.request.serviceTitle;
	self.addressLabel.text = self.viewModel.request.address;

	NSString *hoursStart = [self hoursFromMinutes:self.viewModel.request.location];
	NSString *minutesStart = [self minutesFromMinutes:self.viewModel.request.location];

	NSString *hoursEnd = [self hoursFromMinutes:self.viewModel.request.location + self.viewModel.request.length];
	NSString *minutesEnd = [self minutesFromMinutes:self.viewModel.request.location + self.viewModel.request.length];

	NSString *time = [NSString stringWithFormat:@"%@:%@-%@:%@", hoursStart, minutesStart, hoursEnd, minutesEnd];
	self.timeLabel.text = time;

	self.markerImageView.image = self.viewModel.request.state == SLRRequestStateApprove
		? [UIImage imageNamed:@"book"]
		: [UIImage imageNamed:@"hold"];
}

- (NSString *)numberFromDateString:(NSString *)dateString
{
	NSArray *components = [dateString componentsSeparatedByString:@"-"];
	return [components objectAtIndex:2];
}

- (NSString *)secondFromDateString:(NSString *)dateString
{
	NSArray *components = [dateString componentsSeparatedByString:@"-"];
	return [components objectAtIndex:1];
}

- (NSString *)hoursFromMinutes:(NSInteger)minutes
{
	NSInteger hours = (NSInteger)(minutes / 60.0);
	NSString *returnString = [NSString stringWithFormat:@"%ld", (long)hours];
	return returnString.length > 1
		? returnString
		: [@"0" stringByAppendingString:returnString];
}

- (NSString *)minutesFromMinutes:(NSInteger)minutes
{
	NSInteger m = (NSInteger)(minutes % 60);
	NSString *returnString = [NSString stringWithFormat:@"%ld", (long)m];
	return returnString.length > 1
		? returnString
		: [@"0" stringByAppendingString:returnString];
}

@end
