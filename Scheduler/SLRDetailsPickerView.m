#import "SLRDetailsPickerView.h"

@interface SLRDetailsPickerView ()

@property (nonatomic, strong) UIPickerView *picker;

@end

@implementation SLRDetailsPickerView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	UILabel *titleLabel = [[UILabel alloc] init];
	titleLabel.text = @"Продолжительность:";
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.backgroundColor = [UIColor lightGrayColor];
	[self.contentView addSubview:titleLabel];

	_picker = [[UIPickerView alloc] init];
	[self.contentView addSubview:_picker];

	[titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
												forAxis:UILayoutConstraintAxisVertical];
	[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView);
		make.height.equalTo(@30).with.priorityHigh();
		make.left.equalTo(self.contentView);
		make.right.equalTo(self.contentView);
	}];

	[_picker setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
											 forAxis:UILayoutConstraintAxisVertical];
	[_picker mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(titleLabel.mas_bottom);
		make.left.equalTo(self.contentView);
		make.right.equalTo(self.contentView);
		make.bottom.equalTo(self.contentView);
	}];

	return self;
}

- (void)setViewModel:(SLRDetailsPickerVM *)viewModel
{
	[super setViewModel:viewModel];

	self.picker.delegate = viewModel;
	self.picker.dataSource = viewModel;
	[self.picker reloadAllComponents];
}

@end
