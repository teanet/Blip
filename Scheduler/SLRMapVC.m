#import "SLRMapVC.h"

#import "DGSTileOverlay.h"
#import "SLRFirmMapAnnotation.h"
#import "SLRFirmAnnotationView.h"

static double const kMinimalZoomSquareSide = 2000.0;

@interface SLRMapVC () <MKMapViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) DGSTileOverlay *tilesOverlay;

@end

@implementation SLRMapVC

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
	[self.view addSubview:self.mapView];

	self.view.backgroundColor = [UIColor redColor];

	UIView *statusBarView = [[UIView alloc] init];
	statusBarView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.14];
	[self.view addSubview:statusBarView];

	// [[ Setup Overlays and Annotations and MapView
	self.tilesOverlay = [[DGSTileOverlay alloc] init];
	[_mapView addOverlay:self.tilesOverlay level:MKOverlayLevelAboveLabels];

	self.mapView.delegate = self;
	self.mapView.showsUserLocation = YES;
	self.mapView.mapType = MKMapTypeStandard;
	self.mapView.showsUserLocation = NO;

//	self.mapView.layoutMargins = UIEdgeInsetsMake(14.0, 0.0, 0.0, 8.0);

	[self.mapView addAnnotation:[[SLRFirmMapAnnotation alloc] initWithLocation:self.viewModel.location]];
	// ]]

	[self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view);
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		make.bottom.equalTo(self.view);
	}];

	[statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view);
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		make.height.equalTo(@([UIApplication sharedApplication].statusBarFrame.size.height));
	}];

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
