#import "SLRMapView.h"

#import "DGSTileOverlay.h"
#import "SLRFirmMapAnnotation.h"
#import "SLRFirmAnnotationView.h"

@interface SLRMapView () <MKMapViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) DGSTileOverlay *tilesOverlay;

@end

@implementation SLRMapView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil) return nil;

	[self setupUI];

	return self;
}

- (void)setupUI
{
	self.mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
	[self addSubview:self.mapView];

	self.backgroundColor = [UIColor redColor];

	// [[ Setup Overlays and Annotations and MapView
	self.tilesOverlay = [[DGSTileOverlay alloc] init];
	[_mapView addOverlay:self.tilesOverlay level:MKOverlayLevelAboveLabels];

	self.mapView.delegate = self;
	self.mapView.showsUserLocation = YES;
	self.mapView.mapType = MKMapTypeStandard;
	self.mapView.showsUserLocation = NO;

	//	self.mapView.layoutMargins = UIEdgeInsetsMake(14.0, 0.0, 0.0, 8.0);
	// ]]

	[self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self);
		make.left.equalTo(self);
		make.right.equalTo(self);
		make.bottom.equalTo(self);
	}];
}

- (void)setViewModel:(SLRMapVM *)viewModel
{
	_viewModel = viewModel;

	[self.mapView addAnnotation:[[SLRFirmMapAnnotation alloc] initWithLocation:self.viewModel.location]];

	MKCoordinateRegion region;
	region.center = self.viewModel.location.coordinate;
	region.span.latitudeDelta  = 0.01;
	region.span.longitudeDelta = 0.01;
	[self.mapView setRegion:region animated:NO];

}

// MARK: MapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	NSString *identifier = @"bar";
	MKAnnotationView *view = nil;
	MKAnnotationView *dequeuedView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];

	if ([annotation isKindOfClass:[MKUserLocation class]])
	{
		return nil;
	}

	if ([dequeuedView isKindOfClass:[SLRFirmMapAnnotation class]])
	{
		dequeuedView.annotation = annotation;
		view = dequeuedView;
	}
	else
	{
		view = [[SLRFirmAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"bar"];
	}
	view.annotation = annotation;

	return view;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
	if ([overlay isKindOfClass:[DGSTileOverlay class]])
	{
		MKTileOverlayRenderer *tile = [[MKTileOverlayRenderer alloc] initWithOverlay:overlay];
		return tile;
	}

	return nil;
}

@end
