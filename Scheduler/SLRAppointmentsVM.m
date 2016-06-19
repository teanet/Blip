#import "SLRAppointmentsVM.h"

#import "SLRAppointmentCellVM.h"
#import "SLRDataProvider.h"
#import "SLRUser.h"

@interface SLRAppointmentsVM ()

@property (nonatomic, copy, readwrite) NSArray<SLRAppointmentsVM *> *appointmentVMs;

@end

@implementation SLRAppointmentsVM

- (instancetype)init
{
	self = [super init];
	if (self == nil) return nil;

	_title = @"Мои записи";
	_shouldShowAuthenticateButtonSignal = [[[self rac_signalForSelector:@checkselector(self, showAuthenticateButton:)]
		map:^NSNumber *(RACTuple *tuple) {
			return tuple.first;
		}]
		replayLast];

	BOOL showAuthButton = [SLRDataProvider sharedProvider].user == nil;
	[self showAuthenticateButton:showAuthButton];

	return self;
}

- (void)showAuthenticateButton:(BOOL)show
{
}

- (void)authenticate
{
	@weakify(self);

	[[[SLRDataProvider sharedProvider] fetchAuthenticatedUser]
		subscribeNext:^(id _) {
			@strongify(self);

			[self showAuthenticateButton:NO];
			[self updateAppointments];
		}];
}

- (void)updateAppointments
{
	@weakify(self);

	[[[self.shouldShowAuthenticateButtonSignal
		filter:^BOOL(NSNumber *show) {
			return !show.boolValue;
		}]
		flattenMap:^RACStream *(id _) {
			return [[SLRDataProvider sharedProvider] fetchRequests];
		}]
		subscribeNext:^(NSArray<SLRRequest *> *requests) {
			@strongify(self);

			self.appointmentVMs = [requests.rac_sequence map:^SLRAppointmentCellVM *(SLRRequest *request) {
				return [[SLRAppointmentCellVM alloc] initWithRequest:request];
			}].array;
		}];
}

@end

@implementation SLRAppointmentsVM (UITableView)

- (RACSignal *)shouldUpdateTableViewSignal
{
	return [[RACObserve(self, appointmentVMs) ignore:nil]
		mapReplace:[RACUnit defaultUnit]];
}

- (SLRBaseVM *)cellVMForIndexPath:(NSIndexPath *)indexPath
{
	return [self.appointmentVMs objectAtIndex:indexPath.row];
}

- (NSUInteger)numberOfSections
{
	return 1;
}

- (NSUInteger)numberOfRowsForSection:(NSUInteger)section
{
	return [self.appointmentVMs count];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
