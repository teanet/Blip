#import "SLRDetailsVM.h"

#import "SLRDataProvider.h"
#import "SLRDetailsPickerVM.h"
#import "SLRDetailsServicesVM.h"
#import "SLRDetailsSummaryVM.h"

typedef NS_ENUM(NSUInteger, SLRSection) {
	// Порядок важен - в таком порядке будут отображаться секции в таблице
	SLRSectionPicker = 0,
	SLRSectionService = 1,
	SLRSectionSummary = 2,

	// Порядок важен - это должен быть последний элемент в енуме
	SLRSectionCountOfSections
};

@interface SLRDetailsVM ()

@property (nonatomic, strong, readonly) SLRPage *page;
@property (nonatomic, strong, readonly) SLRRange *range;
@property (nonatomic, strong, readonly) SLRRequest *request;

@property (nonatomic, strong) SLRDetailsPickerVM *pickerVM;
@property (nonatomic, strong) SLRDetailsServicesVM *servicesVM;
@property (nonatomic, strong) SLRDetailsSummaryVM *summaryVM;

@property (nonatomic, strong, readonly) RACSubject *shouldUpdateTableViewSubject;
@property (atomic, assign, readwrite, getter=isServiceProcessing) BOOL serviceProcessing;

@property (nonatomic, copy) NSArray<SLRServiceCellVM *> *serviceVMs;

@end

@implementation SLRDetailsVM

- (instancetype)initWithPage:(SLRPage *)page selectedRange:(SLRRange *)selectedRange
{
	self = [super init];
	if (self == nil) return nil;

	_page = page;
	_range = selectedRange;
	_shouldUpdateTableViewSubject = [RACSubject subject];
	_pickerVM = [[SLRDetailsPickerVM alloc] initWithPage:page selectedRange:selectedRange];
	_servicesVM = [[SLRDetailsServicesVM alloc] initWithTitle:@"Дополнительные услуги:"];
	_summaryVM = [[SLRDetailsSummaryVM alloc] init];

	[self updateServices];

	return self;
}

- (void)dealloc
{
	[_shouldUpdateTableViewSubject sendCompleted];
}

- (void)updateServices
{
	@weakify(self);

	self.serviceProcessing = YES;

	[[[SLRDataProvider sharedProvider] fetchServicesForPage:self.page range:self.range]
		subscribeNext:^(NSArray<SLRService *> *services) {
			@strongify(self);

			self.serviceVMs = [services.rac_sequence
				map:^id(SLRService *service) {
					return [[SLRServiceCellVM alloc] initWithService:service];
				}].array;

			self.serviceProcessing = NO;

			[self.shouldUpdateTableViewSubject sendNext:[RACUnit defaultUnit]];
		}];
}

- (void)didTapBookButton
{
	SLRRequest *request = [self requestWithCurrentOptions];
	self.serviceProcessing = YES;

	[[[[[SLRDataProvider sharedProvider] fetchProcessedRequestForRequest:request]
		deliverOnMainThread]
		flattenMap:^RACStream *(SLRRequest *req) {
			self.serviceProcessing = NO;

			return req.state == SLRRequestStateUndefined
			? [RACSignal error:[NSError errorWithDomain:@"" code:0 userInfo:nil]]
			: [RACSignal return:req];
		}]
		subscribeNext:^(SLRRequest *req) {
			// Здесь возвращаемся на предыдущий экран и обновляем таблицу
		} error:^(NSError *error) {
			// Обрабатываем ошибку
		}];
}

- (SLRRequest *)requestWithCurrentOptions
{
	SLRRequest *request = [[SLRDataProvider sharedProvider] emptyBookingRequest];
	request.location = self.range.location;
	request.length = self.pickerVM.totalSelectedLength;
	request.summary = self.summaryVM.summary;
	request.services = [[self.serviceVMs.rac_sequence
		filter:^BOOL(SLRServiceCellVM *vm) {
			return vm.service.selected;
		}]
		map:^id(SLRServiceCellVM *vm) {
			return vm.service;
		}].array;

	return request;
}

@end


@implementation SLRDetailsVM (UITableView)

- (RACSignal *)shouldUpdateTableViewSignal
{
	return self.shouldUpdateTableViewSubject;
}

- (id<SLRTableViewCellVMProtocol>)cellVMForIndexPath:(NSIndexPath *)indexPath
{
	return [[self sourceArrayForSection:indexPath.section] objectAtIndex:indexPath.row];
}

- (SLRBaseVM *)headerVMForSection:(NSUInteger)section
{
	// Все-таки говно(
	switch ((SLRSection)section)
	{
		case SLRSectionPicker: {
			return self.pickerVM;
		} break;

		case SLRSectionService: {
			return self.servicesVM;
		} break;

		case SLRSectionSummary: {
			return self.summaryVM;
		} break;

		case SLRSectionCountOfSections: {
			// Заглушка на ворнинг.
			NSCAssert(NO, @"Never will get this section.");
			return nil;
		} break;
	}

	return nil;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
	// Все-таки говно(
	switch ((SLRSection)section)
	{
		case SLRSectionPicker: {
			return 150.0;
		} break;

		case SLRSectionService: {
			return 30.0;
		} break;

		case SLRSectionSummary: {
			return 200.0;
		} break;

		case SLRSectionCountOfSections: {
			// Заглушка на ворнинг.
			NSCAssert(NO, @"Never will get this section.");
			return 0.0;
		} break;
	}

	return 0.0;
}

- (NSUInteger)numberOfSections
{
	NSUInteger sectins = SLRSectionCountOfSections;
	return sectins;
}

- (NSUInteger)numberOfRowsForSection:(NSUInteger)section
{
	return [[self sourceArrayForSection:section] count];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[[self cellVMForIndexPath:indexPath] didSelect];
}

// MARK: TableView Private

- (NSArray<id<SLRTableViewCellVMProtocol>> *)sourceArrayForSection:(SLRSection)section
{
	switch (section)
	{
		case SLRSectionPicker: {
			return nil;
		} break;

		case SLRSectionService: {
			return self.serviceVMs;
		} break;

		case SLRSectionSummary: {
			return nil;
		} break;

		case SLRSectionCountOfSections: {
			// Заглушка на ворнинг.
			NSCAssert(NO, @"Never will get this section.");
			return nil;
		} break;
	}

	return nil;
}

@end
