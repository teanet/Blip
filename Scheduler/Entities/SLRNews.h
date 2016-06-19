#import "SLRSerializableProtocol.h"

@interface SLRNews : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *imageURLString;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *dateString;

@end
