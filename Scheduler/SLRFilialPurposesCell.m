#import "SLRFilialPurposesCell.h"

@interface SLRFilialTableView : UITableView

@end

@implementation SLRFilialTableView

- (BOOL)                         gestureRecognizer: (UIGestureRecognizer*)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer: (UIGestureRecognizer*)otherGestureRecognizer
{
	return YES;
//	if ([gestureRecognizer isKindOfClass: [UIPanGestureRecognizer class]])
//	{
//		if ([((UIPanGestureRecognizer*)gestureRecognizer) velocityInView: self].y > 0)
//		{
//			// Up
//			if (self.contentOffset.y <= 0)
//			{
//				self.bounces = NO;
//				return YES;
//			}
//		}
//		else
//		{
//			// Down
//			if (self.contentOffset.y + self.frame.size.height >= self.contentSize.height)
//			{
//				self.bounces = NO;
//				return YES;
//			}
//		}
//	}
//
//	self.bounces = YES;

	return NO;
}

@end

@interface SLRFilialPurposesCell ()

@property (nonatomic, strong) SLRFilialTableView *tableView;

@end

@implementation SLRFilialPurposesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self == nil) return nil;

	self.selectionStyle = UITableViewCellSelectionStyleNone;
	[self setupInterface];

	return self;
}

- (void)setupInterface
{
	self.contentView.backgroundColor = [UIColor whiteColor];
	_tableView = [[SLRFilialTableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
	_tableView.tableFooterView = [[UIView alloc] init];
	[self.contentView addSubview:_tableView];
	[_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.contentView);
	}];
}

- (void)setViewModel:(SLRPurposesVM *)viewModel
{
	[super setViewModel:viewModel];
	[self.viewModel registerTableView:self.tableView];
	[self.tableView reloadData];
}

@end
