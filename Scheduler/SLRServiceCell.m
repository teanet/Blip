#import "SLRServiceCell.h"

@implementation SLRServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	return self;
}

- (void)setViewModel:(SLRServiceCellVM *)viewModel
{
	[super setViewModel:viewModel];
	self.textLabel.text = viewModel.service.title;
	self.textLabel.textColor = viewModel.service.selected
		? [UIColor blackColor]
		: [UIColor lightGrayColor];
}

@end
