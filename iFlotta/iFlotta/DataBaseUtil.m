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
        Auto* aktAuto = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Auto"
                                   inManagedObjectContext:context];

        [aktAuto setValue:[NSNumber numberWithInt:[[result valueForKey:@"autoFoglalt"] intValue] ] forKey:@"autoFoglalt"];
        [aktAuto setValue:[result valueForKey:@"autoNev"] forKey:@"autoNev"];
        [aktAuto setValue:[result valueForKey:@"autoRendszam"] forKey:@"autoRendszam"];
        [aktAuto setValue:[self IsEmpty:[result valueForKey:@"autoLastSoforID"]] ? nil : [NSNumber numberWithInt:[[result valueForKey:@"autoLastSoforID"] intValue] ] forKey:@"autoLastSoforID"];
        [aktAuto setValue:[NSNumber numberWithInt:[[result valueForKey:@"autoID"] intValue] ] forKey:@"autoID"];
        [aktAuto setValue:[NSNumber numberWithInt:[[result valueForKey:@"autoKilometerOra"] intValue] ] forKey:@"autoKilometerOra"];
        [aktAuto setValue:[result valueForKey:@"autoLastSzervizDate"] forKey:@"autoLastSzervizDate"];
        [aktAuto setValue:[self IsEmpty:[result valueForKey:@"autoLastTelephelyID"]] ? nil : [NSNumber numberWithInt:[[result valueForKey:@"autoLastTelephelyID"] intValue] ] forKey:@"autoLastTelephelyID"];
        [aktAuto setValue:[result valueForKey:@"autoLastUpDate"] forKey:@"autoLastUpDate"];
        [aktAuto setValue:[result valueForKey:@"autoMuszakiVizsgaDate"] forKey:@"autoMuszakiVizsgaDate"];
        [aktAuto setValue:[self IsEmpty:[result valueForKey:@"autoProfilKepID"]] ? nil : [NSNumber numberWithInt:[[result valueForKey:@"autoProfilKepID"] intValue] ] forKey:@"autoProfilKepID"];
        [aktAuto setValue:[result valueForKey:@"autoTipus"] forKey:@"autoTipus"];
        [aktAuto setValue:[NSNumber numberWithInt:[[result valueForKey:@"autoUzemAnyag"] intValue] ] forKey:@"autoUzemAnyag"];
        [aktAuto setValue:[NSNumber numberWithFloat:[[result valueForKey:@"autoXkoordinata"] floatValue] ] forKey:@"autoXkoordinata"];
        [aktAuto setValue:[NSNumber numberWithFloat:[[result valueForKey:@"autoYkoordinata"] floatValue] ] forKey:@"autoYkoordinata"];
    }
    
    // 
    
    [self saveContext:context];
}

+ (BOOL) IsEmpty:(id) thing {
    return thing == nil
    || [thing isKindOfClass:[NSNull class]]
    || ([thing respondsToSelector:@selector(length)]
        && ![thing respondsToSelector:@selector(count)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [thing count] == 0);
}
@end
