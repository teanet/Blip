#import "SLRScheduleModel.h"

SPEC_BEGIN(SLRScheduleModelSpec)

describe(@"SLRScheduleModel", ^{

	__block SLRScheduleModel *instance = nil;

	beforeEach(^{

		NSDictionary *d = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[SLRScheduleModel class]] pathForResource:@"schedule_params.json" ofType:nil]] options:0 error:nil];
		instance = [[SLRScheduleModel alloc] initWithDictionary:d];

	});

	it(@"should create", ^{

		[[theValue(instance.step) should] equal:theValue(15)];
		[[theValue(instance.canAdjustInterval) should] beNo];
		[[theValue(instance.availableRange) should] equal:theValue(NSMakeRange(0, 1440))];

	});

	it(@"should get all ranges whithout predefined scheduleIntervals", ^{

		[[instance.allIntervals should] haveCountOf:96];

	});

});

SPEC_END
