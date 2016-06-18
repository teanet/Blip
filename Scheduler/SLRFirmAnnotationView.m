#import "SLRFirmAnnotationView.h"

@implementation SLRFirmAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];

	if (self)
	{
		UIImageView *locationView = [[UIImageView alloc] init];
		locationView.image = [UIImage imageNamed:@"userLocation"];

		[self addSubview:locationView];

		[locationView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.equalTo(self.mas_centerY);
			make.centerX.equalTo(self);
		}];
	}

	return self;
}


@end
