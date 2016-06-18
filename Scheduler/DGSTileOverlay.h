#import <MapKit/MapKit.h>

@interface DGSTileOverlay : MKTileOverlay

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithURLTemplate:(NSString *)URLTemplate NS_UNAVAILABLE;

- (void)cleanTilesCache;

@end
