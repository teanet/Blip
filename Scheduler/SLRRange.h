extern NSInteger const kSLRMinimumLength;

@interface SLRRange : NSObject

@property (nonatomic, assign) NSInteger location;
@property (nonatomic, assign) NSInteger length;
@property (nonatomic, assign, readonly) NSInteger end;

- (void)dragUp:(NSInteger)delta;
- (void)dragDown:(NSInteger)delta;
- (BOOL)containMinute:(NSInteger)minute;
- (BOOL)intercectRange:(SLRRange *)range;

@end
