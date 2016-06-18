#import "SLRProjectSettings.h"

@interface SLRAPIController : NSObject

@property (nonatomic, copy, readonly) NSString *schedulerAPIKey;
@property (nonatomic, copy, readonly) NSString *applicationKey;

- (instancetype)initWithSchedulerAPIKey:(NSString *)schedulerAPIKey
						 applicationKey:(NSString *)applicationKey NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/*! \return NSDictionary */
- (RACSignal *)GET:(NSString *)method params:(NSDictionary *)params;

/*! \return NSDictionary */
- (RACSignal *)POST:(NSString *)method params:(NSDictionary *)params;

- (void)setProjectSettings:(SLRProjectSettings *)projectSettings;

@end
