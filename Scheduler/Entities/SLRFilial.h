#import "SLROwner.h"
#import "SLRPurpose.h"

#import "SLRSerializableProtocol.h"

/*! У проекта может быть несколько филиалов 
	(приложение для парикмахерской с несколькими филиалами по разным адресам, в которых по несколько мастеров).
 {
	"id" : string,
	"title" : string,
	"address" : string,
	"contact" : string,
	"owners" : [
		{},
		{},
		...
	],
	"purposes" : [
		 {},
		 {},
		 ...
	],
 }
 */

@interface SLRFilial : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *mainImageURLString;
@property (nonatomic, copy, readonly) NSString *logoImageURLString;
@property (nonatomic, copy, readonly) CLLocation *location;



@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, copy, readonly) NSString *phone;

@property (nonatomic, copy, readonly) NSArray<SLROwner *> *owners;
@property (nonatomic, copy, readonly) NSArray<SLRPurpose *> *purposes;

@end

@interface SLRFilial (SLRTesting)

+ (SLRFilial *)testFilial;

@end
