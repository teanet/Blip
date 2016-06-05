#import "SLRDetailsPickerVM.h"

@interface SLRDetailsPickerRowVM : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) NSTimeInterval location;
@property (nonatomic, assign, readonly) NSTimeInterval length;

- (instancetype)initWithStartLocation:(NSTimeInterval)startLocation
						  startLength:(NSTimeInterval)startLength
						  rowLocation:(NSTimeInterval)rowLocation
							rowLength:(NSTimeInterval)rowLenght;

@end

@implementation SLRDetailsPickerRowVM

- (instancetype)initWithStartLocation:(NSTimeInterval)startLocation
						  startLength:(NSTimeInterval)startLength
						  rowLocation:(NSTimeInterval)rowLocation
							rowLength:(NSTimeInterval)rowLenght
{
	self = [super init];
	if (self == nil) return nil;

	_title = [self.class titleForStartLocation:startLocation
								   startLength:startLength
								   rowLocation:rowLocation
									 rowLength:rowLenght];
	_location = rowLocation;
	_length = rowLenght;

	return self;
}

+ (NSString *)titleForStartLocation:(NSTimeInterval)startLocation
						startLength:(NSTimeInterval)startLength
						rowLocation:(NSTimeInterval)rowLocation
						  rowLength:(NSTimeInterval)rowLenght
{
	NSTimeInterval totalLength = rowLocation - startLocation + rowLenght + startLength;
	NSInteger hours = (NSInteger)totalLength / 60;
	NSInteger minutes = (NSInteger)totalLength - (hours * 60);

	return hours > 0
		? [NSString stringWithFormat:@"%ld часа %ld минут", hours, minutes]
		: [NSString stringWithFormat:@"%ld минут", minutes];
}

@end

@interface SLRDetailsPickerVM ()

@property (nonatomic, strong, readonly) SLRPage *page;
@property (nonatomic, strong, readonly) SLRRange *range;

@property (nonatomic, copy, readonly) NSArray<SLRDetailsPickerRowVM *> *pickerData;


@end

@implementation SLRDetailsPickerVM

- (instancetype)initWithPage:(SLRPage *)page selectedRange:(SLRRange *)selectedRange
{
	self = [super init];
	if (self == nil) return nil;

	_page = page;
	_range = selectedRange;
	_pickerData = [self generatedPickerData];

	return self;
}

- (NSArray<SLRDetailsPickerRowVM *> *)generatedPickerData
{
	NSMutableArray<SLRDetailsPickerRowVM *> *pickerRows = [NSMutableArray array];
	NSTimeInterval step = self.page.timeGrid.bookingStep;
	NSTimeInterval startLocation = self.range.location + self.range.length;
	NSTimeInterval startLength = self.range.length;

	// Вычисляем расстояние до следующего ренджа
	__block NSTimeInterval endLocation = 0.0;
	[self.page.rangesFree enumerateObjectsUsingBlock:^(SLRRange *range, NSUInteger _, BOOL *stop) {
		if ((range.location <= self.range.location) &&
		    (range.location + range.length > self.range.location))
		{
			endLocation = range.location + range.length;
			*stop = YES;
		}
	}];

	if (endLocation > 0)
	{
		NSTimeInterval availableInterval = endLocation - startLocation;
		NSInteger rangeCount = (NSInteger)(availableInterval / step);
		for (int i = 0; i <= rangeCount; i ++)
		{
			SLRDetailsPickerRowVM *row = [[SLRDetailsPickerRowVM alloc] initWithStartLocation:startLocation + step
																				  startLength:startLength
																				  rowLocation:startLocation + step * i
																					rowLength:step];
			[pickerRows addObject:row];
		}
	}

	return [pickerRows copy];
}

- (BOOL)isAdjustable
{
#warning HERE SWITCH OFF ADJUST SECTION
	return YES;
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return _pickerData[row].title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (row > self.pickerData.count - 1) return;

	SLRDetailsPickerRowVM *rowVM = [self.pickerData objectAtIndex:row];
	NSString *totalLength = [NSString stringWithFormat:@"Total Length: %f", rowVM.location - self.range.location];
	NSLog(@">>> %@", totalLength);
}

@end
