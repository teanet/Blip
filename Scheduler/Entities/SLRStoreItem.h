#import "SLRSerializableProtocol.h"

/*! Это единица товара в магазине
 *	Пока что просто подтягиваем фотки с вконтактика
 **/
@interface SLRStoreItem : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *albumId;
@property (nonatomic, copy, readonly) NSString *ownerId;
@property (nonatomic, copy, readonly) NSString *userId;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *photoSmallURLString;
@property (nonatomic, copy, readonly) NSString *photoLargeURLString;

@end
