//
//  DataBaseUtil.m
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "DataBaseUtil.h"
#import "AppDelegate.h"
#import "JsonUtil.h"
#import "Sofor.h"
#import "Auto.h"
#import "Telephely.h"



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

+ (void)saveContext:(NSManagedObjectContext *)managedObjectContext {
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

+ (NSArray*)fetchRequest:(NSString*) entityName {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

+ (void)fillSoforTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Sofor" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/querySoforTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
    // Adatbázis feltöltése
    for (NSDictionary *result in rows) {
        
        Sofor* aktsofor = [NSEntityDescription
                           insertNewObjectForEntityForName:@"Sofor"
                           inManagedObjectContext:context];
        
        NSString* soforNev = [result valueForKey:@"soforNev"];
        [aktsofor setValue:soforNev forKey:@"soforNev"];
        
        NSString* soforLogin = [result valueForKey:@"soforLogin"];
        [aktsofor setValue:soforLogin forKey:@"soforLogin"];
        
        NSString* soforPass = [result valueForKey:@"soforPass"];
        [aktsofor setValue:soforPass forKey:@"soforPass"];
    }
    
    [self saveContext:context];
}

+ (void)fillTelephelyTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Telephely" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryTelephelyTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
    // Adatbázis feltöltése
    for (NSDictionary *result in rows) {
        
        Telephely* aktTelephely = [NSEntityDescription
                           insertNewObjectForEntityForName:@"Telephely"
                           inManagedObjectContext:context];
        
        NSString* telephelyNev = [result valueForKey:@"telephelyNev"];
        [aktTelephely setValue:telephelyNev forKey:@"telephelyNev"];
        
        NSString* telephelyCim = [result valueForKey:@"telephelyCim"];
        [aktTelephely setValue:telephelyCim forKey:@"telephelyCim"];
        
        NSString* telephelyTelefonszam = [result valueForKey:@"telephelyTelefonszam"];
        [aktTelephely setValue:telephelyTelefonszam forKey:@"telephelyTelefonszam"];
        
        NSString* telephelyEmail = [result valueForKey:@"telephelyEmail"];
        [aktTelephely setValue:telephelyEmail forKey:@"telephelyEmail"];
        
    }
    
    [self saveContext:context];
}

+ (void)fillAutoTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Auto" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryAutoTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
    // Adatbázis feltöltése
    for (NSDictionary *result in rows) {
        
        NSLog(@"adat: %@",result);
        
        Auto* aktAuto = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Auto"
                                   inManagedObjectContext:context];
        
        //NSNumber* autoFoglalt = [result valueForKey:@"autoFoglalt"];
        //[aktAuto setValue:autoFoglalt forKey:@"autoFoglalt"];
        
        NSString* autoNev = [result valueForKey:@"autoNev"];
        [aktAuto setValue:autoNev forKey:@"autoNev"];
        
        NSString* autoRendszam = [result valueForKey:@"autoRendszam"];
        [aktAuto setValue:autoRendszam forKey:@"autoRendszam"];
        
    }
    
    [self saveContext:context];
}
@end
