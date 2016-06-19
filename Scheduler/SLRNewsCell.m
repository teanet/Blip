#import "SLRNewsCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SLRNewsCell ()

@property (nonatomic, strong, readonly) UIImageView *newsImageView;
@property (nonatomic, strong, readonly) UIView *container;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *summaryLabel;

@end

@implementation SLRNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.contentView.backgroundColor = [UIColor dgs_colorWithString:@"F6F6F6"];
	
	UIView *bgColorView = [[UIView alloc] init];
	bgColorView.backgroundColor = [UIColor clearColor];
	[self setSelectedBackgroundView:bgColorView];

	_container = [[UIView alloc] init];
	_container.clipsToBounds = YES;
	_container.layer.cornerRadius = 3.0;
	_container.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:_container];

	_newsImageView = [[UIImageView alloc] init];
	_newsImageView.contentMode = UIViewContentModeScaleAspectFill;
	_newsImageView.clipsToBounds = YES;
	[_container addSubview:_newsImageView];

	_dateLabel = [[UILabel alloc] init];
	_dateLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	_dateLabel.textAlignment = NSTextAlignmentLeft;
	_dateLabel.numberOfLines = 1;
	_dateLabel.textColor = [UIColor lightGrayColor];
	[_container addSubview:_dateLabel];

	_summaryLabel = [[UILabel alloc] init];
	_summaryLabel.font = [UIFont dgs_regularDisplayTypeFontOfSize:16.0];
	_summaryLabel.textAlignment = NSTextAlignmentLeft;
	_summaryLabel.numberOfLines = 0;
	_summaryLabel.textColor = [UIColor blackColor];
	[_container addSubview:_summaryLabel];

	[_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_newsImageView.mas_bottom).with.offset(15.0);
		make.leading.equalTo(_newsImageView).with.offset(17.0);
		make.trailing.lessThanOrEqualTo(_newsImageView).with.offset(-17.0);
	}];

	[_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_dateLabel.mas_bottom).with.offset(5.0);
		make.leading.equalTo(_newsImageView).with.offset(17.0);
		make.trailing.lessThanOrEqualTo(_newsImageView).with.offset(-17.0);
		make.bottom.lessThanOrEqualTo(_container).with.offset(-15.0);
	}];

	[_newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_container);
		make.leading.equalTo(_container);
		make.trailing.equalTo(_container);
		make.height.equalTo(@200);
	}];

	[_container mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView).with.offset(9.0);
		make.leading.equalTo(self.contentView).with.offset(7.0);
		make.trailing.equalTo(self.contentView).with.offset(-7.0);
		make.bottom.equalTo(self.contentView);
	}];

	return self;
}

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	NSURL *url = [NSURL URLWithString:self.viewModel.imageURLString];
	[self.newsImageView setImageWithURL:url];

	self.dateLabel.text = self.viewModel.dateString;
	self.summaryLabel.text = self.viewModel.summary;
}

@end
