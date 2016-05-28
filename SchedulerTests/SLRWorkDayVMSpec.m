#import "SLRWorkDayVM.h"

SPEC_BEGIN(SLRWorkDayVMSpec)

describe(@"SLRWorkDayVM", ^{

	__block SLRWorkDayVM *instance = nil;
	__block SLRIntervalVM *intervalVM = nil;

	beforeEach(^{

		instance = [[SLRWorkDayVM alloc] initWithPage:nil];
		intervalVM = [[SLRIntervalVM alloc] init];

	});

	it(@"should not intercect", ^{


	});

});

SPEC_END
