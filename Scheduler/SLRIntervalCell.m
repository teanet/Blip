#import "SLRIntervalCell.h"

@implementation SLRIntervalCell

- (void)setIntervalVM:(SLRIntervalVM *)intervalVM
{
	_intervalVM = intervalVM;
	self.backgroundColor = [intervalVM color];
	self.textLabel.text = [intervalVM timeString];
}

@end
