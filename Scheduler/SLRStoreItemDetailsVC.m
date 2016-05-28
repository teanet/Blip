#import "SLRStoreItemDetailsVC.h"

#import "SLRDataProvider.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation SLRStoreItemDetailsVC

- (instancetype)initWithViewModel:(SLRStoreItemDetailsVM *)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;

	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	self.modalPresentationStyle = UIModalPresentationOverFullScreen;

	return self;
}

- (void)viewDidLoad
{
	self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
	UIView *contentView = [[UIView alloc] init];
	contentView.layer.cornerRadius = 5.0;
	contentView.layer.masksToBounds = YES;
	[self.view addSubview:contentView];

	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.layer.cornerRadius = 5.0;
	[imageView setImageWithURL:[NSURL URLWithString:self.viewModel.storeItem.photoLargeURLString]];
	[contentView addSubview:imageView];

	UILabel *summaryLabel = [[UILabel alloc] init];
	summaryLabel.numberOfLines = 0;
	summaryLabel.font = [UIFont systemFontOfSize:14.0];
	summaryLabel.textColor = [UIColor whiteColor];
	summaryLabel.text = self.viewModel.storeItem.summary;
	[contentView addSubview:summaryLabel];

	UIButton *backButton = [[UIButton alloc] init];
	backButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
	backButton.layer.cornerRadius = 40.0;
	backButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
	[backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[backButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
	[backButton setTitle:@"Назад" forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(didTapCloseButton) forControlEvents:UIControlEventTouchUpInside];
	[contentView addSubview:backButton];

	UIButton *cartButton = [[UIButton alloc] init];
	cartButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
	cartButton.layer.cornerRadius = 40.0;
	cartButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
	[cartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[cartButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];

	NSString *title = self.viewModel.style == SLRStoreItemDetailsStyleAdd
		? @"В корзину"
		: @"Из корзины";
	[cartButton setTitle:title forState:UIControlStateNormal];

	SEL selector = self.viewModel.style == SLRStoreItemDetailsStyleAdd
		? @selector(didTapAddToCartButton)
		: @selector(didTapRemoveFromCartButton);

	[cartButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
	[contentView addSubview:cartButton];

	[contentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(25.0, 10.0, 25.0, 10.0));
	}];

	[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(contentView).with.offset(8.0);
		make.left.equalTo(contentView).with.offset(32.0);
		make.right.equalTo(contentView).with.offset(-32.0);
		make.height.equalTo(@(200.0));
	}];

	[summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(imageView.mas_bottom).with.offset(32.0);
		make.left.equalTo(imageView);
		make.right.equalTo(imageView);
	}];

	[backButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.greaterThanOrEqualTo(summaryLabel.mas_bottom).with.offset(32.0);
		make.left.equalTo(imageView);
		make.width.equalTo(@80.0);
		make.height.equalTo(@80.0);
		make.bottom.equalTo(contentView).with.offset(-32.0);
	}];

	[cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(imageView);
		make.width.equalTo(@80.0);
		make.height.equalTo(@80.0);
		make.centerY.equalTo(backButton);
	}];
}

- (void)didTapCloseButton
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapAddToCartButton
{
	[[SLRDataProvider sharedProvider] addStoreItemToCart:self.viewModel.storeItem];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapRemoveFromCartButton
{
	[[SLRDataProvider sharedProvider] removeStoreItemFromCart:self.viewModel.storeItem];
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
