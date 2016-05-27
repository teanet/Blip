#import "SLRBaseVM.h"

#import "SLRService.h"
#import "SLRTableViewCellVMProtocol.h"

@interface SLRServiceCellVM : SLRBaseVM <SLRTableViewCellVMProtocol>

@property (nonatomic, strong, readonly) SLRService *service;

- (instancetype)initWithService:(SLRService *)service;

@end
