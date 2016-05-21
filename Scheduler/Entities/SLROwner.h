#import "SLRSerializableProtocol.h"

/*! Субъект (владелец) расписания.
	Это та сущность, к которой относится расписание (мастер в парикмахерской, комната репетиционной базы, пост СТО...)
 {
	"id" : "id",
	"title" : "title",
 }
 **/

@interface SLROwner : NSObject <SLRSerializableProtocol>

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *title;

@end
