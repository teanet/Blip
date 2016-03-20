@protocol SLRScheduleInterval <NSObject>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIColor *color;
//@property (nonatomic, strong, readonly) id<SLRScheduleReason> reason;
@property (nonatomic, assign, readonly) NSRange range;

@end
