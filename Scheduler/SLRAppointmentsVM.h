#import "SLRBaseVM.h"

@class SLRAppointmentsVM;

@interface SLRAppointmentsVM : SLRBaseVM

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) RACSignal *shouldShowAuthenticateButtonSignal;

- (void)authenticate;
- (void)updateAppointments;

@end

@interface SLRAppointmentsVM (UITableView)

- (RACSignal *)shouldUpdateTableViewSignal;

- (SLRBaseVM *)cellVMForIndexPath:(NSIndexPath *)indexPath;
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsForSection:(NSUInteger)section;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
