#import "SLRRootVM.h"

#import "SLRAboutVM.h"
#import "SLRAppointmentsVM.h"
#import "SLRDataProvider.h"
#import "SLRHomeVM.h"
#import "SLRFilial.h"

@interface SLRRootVM ()

@property (nonatomic, strong, readwrite) SLRAboutVM *aboutVM;
@property (nonatomic, strong, readwrite) SLRAppointmentsVM *appointmentsVM;
@property (nonatomic, strong, readwrite) SLRHomeVM *homeVM;
@property (nonatomic, assign, readwrite) BOOL readyToUse;

@end

@implementation SLRRootVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_readyToUse = NO;

	[self fetchModels];

	return self;
}

- (void)registerUserIfNeeded
{
	if ([SLRDataProvider sharedProvider].user)
	{
		[[SLRDataProvider sharedProvider] fetchAuthenticatedUser];
	}
}

- (void)fetchModels
{
	@weakify(self);

	[[[SLRDataProvider sharedProvider] fetchFilials]
		subscribeNext:^(NSArray<SLRFilial *> *filials) {
			@strongify(self);

			SLRFilial *filial = filials.firstObject;

			self.aboutVM = [[SLRAboutVM alloc] initWithFilial:filial];
			self.appointmentsVM = [[SLRAppointmentsVM alloc] init];
			self.homeVM = [[SLRHomeVM alloc] initWithFilials:filials];

			[self configureAppearance];

			self.readyToUse = YES;
		}];
}

- (void)configureAppearance
{
	[[UINavigationBar appearance] setTitleTextAttributes: @{
		NSForegroundColorAttributeName: [UIColor whiteColor],
		NSFontAttributeName: [UIFont dgs_boldDisplayTypeFontOfSize:18.0],
	}];
	
	[[UINavigationBar appearance] setOpaque:YES];
	[[UINavigationBar appearance] setBarTintColor:[SLRDataProvider sharedProvider].projectSettings.navigaitionBarColor];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

@end
