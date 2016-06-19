#import "SLRMonthHeaderView.h"

#import "SLRDataProvider.h"

@interface SLRMonthHeaderView ()

@property (nonatomic, copy, readonly) UILabel *monthLabel;
@property (nonatomic, copy, readonly) UIImageView *daysImageView;

@end

@implementation SLRMonthHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [UIColor whiteColor];

	UIView *divider = [[UIView alloc] init];
	divider.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
	[self.contentView addSubview:divider];

	_monthLabel = [[UILabel alloc] init];
	_monthLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:18.0];
	_monthLabel.textColor = [UIColor darkGrayColor];
	_monthLabel.textAlignment = NSTextAlignmentLeft;
	[self.contentView addSubview:_monthLabel];

	_daysImageView = [[UIImageView alloc] init];
	_daysImageView.image = [UIImage imageNamed:@"days"];
	_daysImageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.contentView addSubview:_daysImageView];

	[divider mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView);
		make.height.equalTo(@1);
		make.leading.equalTo(self.contentView).with.offset(20.0);
		make.trailing.equalTo(self.contentView).with.offset(-20.0);
	}];

	[_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.contentView).with.offset(35.0);
		make.top.equalTo(self.contentView).with.offset(12.0);
	}];

	[_daysImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.contentView);
		make.top.equalTo(_monthLabel.mas_bottom).with.offset(14.0);
	}];

	return self;
}

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	self.monthLabel.text = self.viewModel.month;
}

@end
