#import "SLRScheduleCell.h"

@implementation SLRScheduleCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	self.contentView.backgroundColor = [UIColor lightGrayColor];

	return self;
}

- (void)setViewModel:(SLRScheduleCellVM *)viewModel
{
	_viewModel = viewModel;
	self.contentView.backgroundColor = [viewModel.interval color];
}


@end
