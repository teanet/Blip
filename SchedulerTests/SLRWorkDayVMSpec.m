#import "SLRWorkDayVM.h"

SPEC_BEGIN(SLRWorkDayVMSpec)

describe(@"SLRWorkDayVM", ^{

	__block SLRWorkDayVM *instance = nil;
	__block SLRIntervalVM *intervalVM = nil;
	__block SLRRange *range = nil;

	beforeEach(^{

		instance = [[SLRWorkDayVM alloc] init];
		intervalVM = [[SLRIntervalVM alloc] init];
		range = [[SLRRange alloc] init];

	});

	it(@"should not intercect", ^{

		range.length = -20;
		[instance interval:intervalVM didChangeRange:range];

	});

});

SPEC_END
