//
//  DataBaseUtil.m
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "DataBaseUtil.h"

@implementation DataBaseUtil

+ (void) deleteAllObjects: (NSString *) entityDescription  :(NSManagedObjectContext*) context {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
    	[context deleteObject:managedObject];
    }
}

+ (void)saveContext:(NSManagedObjectContext *)managedObjectContext
{
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
