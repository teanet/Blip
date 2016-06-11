#import "SLRPurposeCell.h"

@implementation SLRPurposeCell

- (void)setViewModel:(id)viewModel
{
	[super setViewModel:viewModel];

	self.textLabel.text = self.viewModel.title;
}

@end
