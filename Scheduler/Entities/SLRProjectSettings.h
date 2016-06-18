#import "SLRSerializableProtocol.h"

@interface SLRProjectSettings : NSObject <SLRSerializableProtocol>

@property (nonatomic, strong, readonly) UIColor *navigaitionBarColor;

@end
