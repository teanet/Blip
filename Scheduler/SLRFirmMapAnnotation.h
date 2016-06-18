@interface SLRFirmMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong, readonly) CLLocation *location;

- (instancetype)initWithLocation:(CLLocation *)location;

@end
