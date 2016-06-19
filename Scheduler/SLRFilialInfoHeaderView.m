#import "SLRFilialInfoHeaderView.h"

#import "SLRDataProvider.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SLRFilialInfoHeaderView ()

@property (nonatomic, strong, readonly) UIImageView *logoImageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *summaryLabel;

@end

@implementation SLRFilialInfoHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [SLRDataProvider sharedProvider].projectSettings.navigaitionBarColor;

	[self setupUI];

	return self;
}

- (void)setupUI
{
	_logoImageView = [[UIImageView alloc] init];
	_logoImageView.layer.cornerRadius = 30.0;
	_logoImageView.contentMode = UIViewContentModeScaleAspectFit;
	[self addSubview:_logoImageView];

	_titleLabel = [[UILabel alloc] init];
	_titleLabel.font = [UIFont dgs_boldDisplayTypeFontOfSize:18.0];
	_titleLabel.textColor = [UIColor whiteColor];
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	[self addSubview:_titleLabel];

	_summaryLabel = [[UILabel alloc] init];
	_summaryLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	_summaryLabel.textColor = [UIColor whiteColor];
	_summaryLabel.textAlignment = NSTextAlignmentCenter;
	_summaryLabel.numberOfLines = 3;
	[self addSubview:_summaryLabel];

	[_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self).with.offset(37.0);
		make.centerX.equalTo(self);
		make.size.mas_equalTo(CGSizeMake(60.0, 60.0));
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(@107.0);
		make.centerX.equalTo(self);
		make.width.equalTo(self).with.offset(-64.0);
	}];

	[_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(@124.0);
		make.centerX.equalTo(self);
		make.width.equalTo(_titleLabel);
	}];
}

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	NSURL *imageURL = [NSURL URLWithString:self.viewModel.logoImageURLString];
	[self.logoImageView setImageWithURL:imageURL];

	self.titleLabel.text = self.viewModel.title;
	self.summaryLabel.text = self.viewModel.summary;

}

@end
