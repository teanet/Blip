#import "SLRSerializableProtocol.h"

@interface SLRProjectSettings : NSObject <SLRSerializableProtocol>

@property (nonatomic, strong, readonly) UIColor *navigaitionBarColor;
@property (nonatomic, strong, readonly) UIColor *navigaitionBarBGColor;
@property (nonatomic, copy, readonly) NSString *logoImageURLString;
@property (nonatomic, copy, readonly) UIImage *logoImage;


@end
