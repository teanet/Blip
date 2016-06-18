#import "SLRBaseVM.h"

@class SLRAboutVM;
@class SLRAppointmentsVM;
@class SLRHomeVM;

@interface SLRRootVM : SLRBaseVM

@property (nonatomic, strong, readonly) SLRAboutVM *aboutVM;
@property (nonatomic, strong, readonly) SLRAppointmentsVM *appointmentsVM;
@property (nonatomic, strong, readonly) SLRHomeVM *homeVM;

@property (nonatomic, assign, readonly) BOOL readyToUse;

@end
