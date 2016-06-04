#import "SLRStoreItemDetailsVC.h"

#import "SLRDataProvider.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "UIColor+DGSCustomColor.h"

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
	contentView.backgroundColor = [UIColor dgs_colorWithString:@"FBFAF9"];
	[self.view addSubview:contentView];

	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.backgroundColor = [UIColor whiteColor];
	[imageView setImageWithURL:[NSURL URLWithString:self.viewModel.storeItem.photoLargeURLString]];
	[contentView addSubview:imageView];

	UILabel *summaryLabel = [[UILabel alloc] init];
	summaryLabel.numberOfLines = 0;
	summaryLabel.font = [UIFont systemFontOfSize:14.0];
	summaryLabel.textColor = [UIColor blackColor];
	summaryLabel.text = self.viewModel.storeItem.summary;
	[contentView addSubview:summaryLabel];

//	UIView *maskView = [[UIView alloc] init];
//	maskView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
//	[contentView addSubview:maskView];

	UIView *buttonsContainer = [[UIView alloc] init];
	buttonsContainer.backgroundColor = [UIColor dgs_colorWithString:@"F3F0EC"];
	[contentView addSubview:buttonsContainer];

	UIButton *backButton = [self newButton];
	[backButton setTitle:@"Назад" forState:UIControlStateNormal];
	[backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	backButton.backgroundColor = [UIColor grayColor];
	[backButton addTarget:self action:@selector(didTapCloseButton) forControlEvents:UIControlEventTouchUpInside];
	[buttonsContainer addSubview:backButton];


	UIButton *cartButton = [self newButton];

	NSString *title = self.viewModel.style == SLRStoreItemDetailsStyleAdd
		? @"В корзину"
		: @"Из корзины";

	[cartButton setTitle:title forState:UIControlStateNormal];
	[cartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[cartButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	cartButton.backgroundColor = [UIColor dgs_colorWithString:@"1976D2"];

	SEL selector = self.viewModel.style == SLRStoreItemDetailsStyleAdd
		? @selector(didTapAddToCartButton)
		: @selector(didTapRemoveFromCartButton);

	[cartButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
	[buttonsContainer addSubview:cartButton];

	[cartButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
	[contentView addSubview:cartButton];

	[contentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(32.0, 16.0, 32.0, 16.0));
	}];

	[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(contentView);
		make.left.equalTo(contentView);
		make.right.equalTo(contentView);
		make.height.equalTo(contentView).with.multipliedBy(2.0/3.0).with.offset(-32.0);
	}];

	[summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(imageView.mas_bottom).with.offset(8.0);
		make.left.equalTo(imageView).with.offset(16.0);
		make.right.equalTo(imageView).with.offset(-16.0);
	}];

//	[maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.equalTo(summaryLabel).with.offset(18.0);
//		make.left.equalTo(contentView);
//		make.right.equalTo(contentView);
//		make.bottom.equalTo(contentView).with.offset(-64.0);
//	}];

	[buttonsContainer mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(contentView);
		make.right.equalTo(contentView);
		make.bottom.equalTo(contentView);
	}];

	[backButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(buttonsContainer).with.offset(16.0);
		make.height.equalTo(@44.0);
		make.top.equalTo(buttonsContainer).with.offset(12.0);
		make.bottom.equalTo(buttonsContainer).with.offset(-10.0);
	}];

	[cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(backButton.mas_right).with.offset(8.0);
		make.height.equalTo(@44.0);
		make.right.equalTo(buttonsContainer).with.offset(-16.0);
		make.centerY.equalTo(backButton);
		make.width.equalTo(backButton).with.multipliedBy(2.0);
	}];
}

- (UIButton *)newButton
{
	UIButton *newButton = [[UIButton alloc] init];
	newButton.layer.cornerRadius = 5.0;
	newButton.layer.masksToBounds = YES;
	newButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
	[newButton setContentEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
	return newButton;
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
