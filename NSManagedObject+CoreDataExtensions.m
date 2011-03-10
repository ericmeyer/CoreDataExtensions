#import "NSManagedObject+CoreDataExtensions.h"

static NSManagedObjectContext *managedObjectContext = nil;

@implementation NSManagedObject (CoreDataExtensions)

-(id) init {
	self = [self initWithEntity: [self entity] insertIntoManagedObjectContext: [NSManagedObject managedObjectContext]];
	return self;
}

+(void) setManagedObjectContext:(NSManagedObjectContext*) context {
	managedObjectContext = context;
}

+(NSManagedObjectContext*) managedObjectContext {
	return managedObjectContext;
}

+(int) count {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity: [self entity]];
	[request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)
	
	NSError *err;
	NSUInteger count = [[self managedObjectContext] countForFetchRequest:request error:&err];
	if(count == NSNotFound) {
		//Handle error
	}
	
	[request release];
	return count;
}

+(void) deleteAll {
	for (NSManagedObject* project in [self all]) {
		[[self managedObjectContext] deleteObject: project];
	}
}

+(NSArray*) all {
	NSFetchRequest* projectsRequest = [[NSFetchRequest alloc] init];
	[projectsRequest setEntity: [self entity]];
	[projectsRequest setIncludesPropertyValues:NO];
	
	NSError* error = nil;
	NSArray* projects = [[self managedObjectContext] executeFetchRequest: projectsRequest error:&error];
	[projectsRequest release];
	return projects;
}

-(void) save {
	NSError *error = nil;
	if (![[self managedObjectContext] save:&error]) {
		NSLog(@">>>>>> Error saving: %@", error);
	}
}

+(NSEntityDescription*) entity {
	return [NSEntityDescription entityForName: [self entityName] inManagedObjectContext: [self managedObjectContext]];
}

+(NSString*) entityName {
	return NSStringFromClass(self);
}

-(NSEntityDescription*) entity {
	return [[self class] entity];
}

@end
