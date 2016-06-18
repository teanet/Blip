#import "DGSTileOverlay.h"

//NSString *template = @"http://tile2.retina.maps.2gis.com/tiles?x={x}&y={y}&z={z}&v=1";

// http://tiles.salov.webapi.ostack.test/tiles?z={z}&x={x}&y={y}
//static NSString *const kDGSMapViewTemplate = @"http://tile2.retina.maps.2gis.com/tiles?x={x}&y={y}&z={z}&v=1";
//static NSString *const kDGSMapViewURLStringFormat = @"http://tile2.retina.maps.2gis.com/tiles?x=%ld&y=%ld&z=%ld&v=2";

static NSString *const kDGSMapViewTemplate = @"http://tile2.maps.2gis.com/tiles?x={x}&y={y}&z={z}&v=1";
static NSString *const kDGSMapViewURLStringFormat = @"http://tile2.maps.2gis.com/tiles?x=%ld&y=%ld&z=%ld&v=2";

@implementation DGSTileOverlay

- (instancetype)init
{
	self = [super initWithURLTemplate:kDGSMapViewTemplate];
	if (self == nil) return nil;

	self.maximumZ = 18;
//	self.tileSize = CGSizeMake(512.0, 512.0);
	self.canReplaceMapContent = YES;

	return self;
}

- (NSString *)URLTemplate
{
	return kDGSMapViewTemplate;
}

- (NSURL *)URLForTilePath:(MKTileOverlayPath)path
{
	NSString *urlString = [NSString stringWithFormat:kDGSMapViewURLStringFormat, (long)path.x, (long)path.y, (long)path.z];
	return [NSURL URLWithString:urlString];
}

- (void)loadTileAtPath:(MKTileOverlayPath)path result:(void (^)(NSData * _Nullable, NSError * _Nullable))result
{
	@weakify(self);

	NSURL *url = [self URLForTilePath:path];
	void (^cachedResultBlock)(NSData * _Nullable, NSError * _Nullable) = [result copy];

	NSData *cachedData = [self.class.tilesCache objectForKey:url.absoluteString];
	if (cachedData.length > 0)
	{
		result(cachedData, nil);
	}
	else
	{
		[[NSData rac_readContentsOfURL:url
								options:NSDataReadingMappedIfSafe
							  scheduler:[RACScheduler scheduler]]
			subscribeNext:^(NSData *tileData) {
				@strongify(self);

				if (tileData.length > 0)
				{
					[self.class.tilesCache setObject:tileData forKey:url.absoluteString];
				}

				cachedResultBlock(tileData, nil);
			}];
	}
}

- (void)cleanTilesCache
{
	[self.class.tilesCache removeAllObjects];
}

+ (NSCache *)tilesCache
{
	static NSCache *cache;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		cache = [[NSCache alloc] init];
	});

	return cache;
}

@end
