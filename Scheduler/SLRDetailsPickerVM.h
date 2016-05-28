#import "SLRBaseVM.h"

#import "SLRRange.h"
#import "SLRPage.h"

@interface SLRDetailsPickerVM : SLRBaseVM <UIPickerViewDelegate, UIPickerViewDataSource>

- (instancetype)initWithPage:(SLRPage *)page selectedRange:(SLRRange *)selectedRange NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
