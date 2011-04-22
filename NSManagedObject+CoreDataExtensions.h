#import <CoreData/CoreData.h>
#import "CoreDataExtensions.h"

@interface NSManagedObject (CoreDataExtensions) <CoreDataExtensions>

#pragma mark -
#pragma mark Setting and getting the Managed Object Context
+(void) setManagedObjectContext:(NSManagedObjectContext*) context;
+(NSManagedObjectContext*) managedObjectContext;

#pragma mark -
#pragma mark Class Level Object Manipulation
+(int) count;
+(void) deleteAll;
+(NSArray*) all;

#pragma mark -
#pragma mark Instance Level Object Manipulation
-(void) save;

#pragma mark -
#pragma mark Entity Creation
+(NSEntityDescription*) entity;
-(NSEntityDescription*) entity;

@end
