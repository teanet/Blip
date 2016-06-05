#import "SLRAppointmentCell.h"

@implementation SLRAppointmentCell

- (void)setViewModel:(SLRAppointmentCellVM *)viewModel
{
	[super setViewModel:viewModel];

	self.textLabel.text = viewModel.text;
}

@end
