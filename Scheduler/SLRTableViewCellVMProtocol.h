@protocol SLRTableViewCellVMDelegate <NSObject>

- (void)updateState;

@end

@protocol SLRTableViewCellVMProtocol <NSObject>

@property (nonatomic, weak) id<SLRTableViewCellVMDelegate> delegate;

- (void)didSelect;

@end
