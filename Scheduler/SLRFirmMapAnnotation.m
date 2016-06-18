#import "SLRFirmMapAnnotation.h"

@implementation SLRFirmMapAnnotation

- (instancetype)initWithLocation:(CLLocation *)location
{
	self = [super init];
	if (self == nil) return nil;

	_location = location;

	return self;
}

- (CLLocationCoordinate2D)coordinate
{
	return self.location.coordinate;
}

@end
