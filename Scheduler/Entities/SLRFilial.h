#import "SLROwner.h"

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
 }
 */

@interface SLRFilial : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, copy, readonly) NSString *contact;
@property (nonatomic, copy, readonly) NSArray<SLROwner *> *owners;

@end

@interface SLRFilial (SLRTesting)

+ (SLRFilial *)testFilial;

@end
