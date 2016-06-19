#import "SLRIntervalCell.h"

@interface SLRIntervalCell ()

@property (nonatomic, strong, readonly) UILabel *intervalLabel;


@end

@implementation SLRIntervalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	_intervalLabel = [[UILabel alloc] init];
	_intervalLabel.font = [UIFont dgs_boldDisplayTypeFontOfSize:14.0];
	_intervalLabel.textColor = [UIColor blackColor];
	_intervalLabel.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:_intervalLabel];

	[_intervalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.contentView);
		make.width.lessThanOrEqualTo(self.contentView);
	}];

	self.preservesSuperviewLayoutMargins = YES;
	self.layoutMargins = UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0);

	return self;
}

- (void)setIntervalVM:(SLRIntervalVM *)intervalVM
{
	_intervalVM = intervalVM;
	self.backgroundColor = [intervalVM color];
	self.intervalLabel.text = [intervalVM timeString];
}

@end
