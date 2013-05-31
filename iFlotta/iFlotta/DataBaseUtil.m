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
#import "Partner.h"
#import "Munka.h"
#import "Munkatipus.h"
#import "Autokep.h"
#import "Profilkep.h"


@implementation DataBaseUtil
static NSString *isAdmin;
static NSString *aktUserID;
static NSString *foglaltautoID;

+ (NSString*)aktUserAdmin
{
    return isAdmin;
}
+ (NSString*)aktUserID
{
    return aktUserID;
}

+ (NSString*)foglaltAutoID
{
    return foglaltautoID;
}

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

+(void) setUser:(NSString*)admin :(NSString*)userid :(NSString*)foglaltauto {
    isAdmin = admin;
    aktUserID = userid;
    foglaltautoID = foglaltauto;
}

+ (NSArray*)fetchRequestJarmu:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) tipusName {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];

    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                               entityForName:entityName inManagedObjectContext:context];

    NSPredicate *IsActivePredicate = [NSPredicate predicateWithFormat:@"%K == %@ && autoTipus == %@", IsActiveName, IsActive, tipusName];
    [fetchRequest setPredicate:IsActivePredicate];
    [fetchRequest setEntity:entity];

    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;

}

+ (NSArray*)fetchRequestJarmu:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) tipusName :(NSString*) sortName :(NSNumber*) sortType{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    
    NSPredicate *IsActivePredicate = [NSPredicate predicateWithFormat:@"%K == %@ && autoTipus == %@", IsActiveName, IsActive, tipusName];
    
    NSSortDescriptor *sortDescriptors = [[NSSortDescriptor alloc] initWithKey:sortName ascending:[sortType boolValue]];
    
    [fetchRequest setPredicate:IsActivePredicate];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptors]];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
    
}

+ (NSArray*)fetchRequestSzabadMunka:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSNumber*) soforID {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    
    NSPredicate *IsActivePredicate = [NSPredicate predicateWithFormat:@"%K == %@ && soforID == %@", IsActiveName, IsActive, soforID];
    
    [fetchRequest setPredicate:IsActivePredicate];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

+ (NSArray*)fetchRequestSzabadMunka:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) soforID :(NSString*) sortName :(NSNumber*) sortType {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    
    NSPredicate *IsActivePredicate = [NSPredicate predicateWithFormat:@"%K == %@ && soforID == %@", IsActiveName, IsActive, soforID];

    NSSortDescriptor *sortDescriptors = [[NSSortDescriptor alloc] initWithKey:sortName ascending:[sortType boolValue]];
    
    [fetchRequest setPredicate:IsActivePredicate];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptors]];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

+ (NSArray*)fetchRequest:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) sortName :(NSNumber*) sortType {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    
    NSPredicate *IsActivePredicate = [NSPredicate predicateWithFormat:@"%K == %@", IsActiveName, IsActive];   
    
    NSSortDescriptor *sortDescriptors = [[NSSortDescriptor alloc] initWithKey:sortName ascending:[sortType boolValue]];
    
    [fetchRequest setPredicate:IsActivePredicate];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptors]];                                             
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

+ (NSArray*)fetchRequest:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    
    NSPredicate *IsActivePredicate = [NSPredicate predicateWithFormat:@"%K == %@", IsActiveName, IsActive];
    
    [fetchRequest setPredicate:IsActivePredicate];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

+ (NSArray*)fetchAllRequest:(NSString*) entityName {
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
        
        [aktsofor setValue:[result valueForKey:@"soforNev"] forKey:@"soforNev"];
        [aktsofor setValue:[result valueForKey:@"soforLogin"] forKey:@"soforLogin"];
        [aktsofor setValue:[result valueForKey:@"soforPass"] forKey:@"soforPass"];
        [aktsofor setValue:[NSNumber numberWithBool:[[result valueForKey:@"soforIsActive"] boolValue] ] forKey:@"soforIsActive"];
        [aktsofor setValue:[NSNumber numberWithBool:[[result valueForKey:@"soforIsAdmin"] boolValue] ] forKey:@"soforIsAdmin"];
        [aktsofor setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforID"] intValue] ] forKey:@"soforID"];
        [aktsofor setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforProfilKepId"] intValue] ] forKey:@"soforProfilKepId"];
        [aktsofor setValue:[result valueForKey:@"soforBirthDate"] forKey:@"soforBirthDate"];
        [aktsofor setValue:[result valueForKey:@"soforCim"] forKey:@"soforCim"];
        [aktsofor setValue:[result valueForKey:@"soforEmail"] forKey:@"soforEmail"];
        [aktsofor setValue:[result valueForKey:@"soforRegTime"] forKey:@"soforRegTime"];
        [aktsofor setValue:[result valueForKey:@"soforTelefonszam"] forKey:@"soforTelefonszam"];
    }
    
    [self saveContext:context];
}

+ (void)fillAutokepTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Autokep" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryAutoKepTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     
     Autokep* aktAutokep = [NSEntityDescription
     insertNewObjectForEntityForName:@"Autokep"
     inManagedObjectContext:context];
         
         if (![self IsEmpty:([result valueForKey:@"autoKepPath"])]) {
             [aktAutokep setValue:[result valueForKey:@"autoKepPath"] forKey:@"autoKepPath"];
         }
         if (![self IsEmpty:([result valueForKey:@"autoKepID"])]) {
             [aktAutokep setValue:[NSNumber numberWithInt:[[result valueForKey:@"autoKepID"] intValue] ] forKey:@"autoKepID"];
         }
         if (![self IsEmpty:([result valueForKey:@"autoKepDateTime"])]) {
             [aktAutokep setValue:[result valueForKey:@"autoKepDateTime"] forKey:@"autoKepDateTime"];
         }
         if (![self IsEmpty:([result valueForKey:@"autoID"])]) {
             [aktAutokep setValue:[NSNumber numberWithInt:[[result valueForKey:@"autoID"] intValue] ] forKey:@"autoID"];
         }
     
     }
    
    [self saveContext:context];
}

+ (void)fillPartnerTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Partner" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryPartnerTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     
     Partner* aktPartner = [NSEntityDescription insertNewObjectForEntityForName:@"Partner" inManagedObjectContext:context];
     
     [aktPartner setValue:[result valueForKey:@"partnerCim"] forKey:@"partnerCim"];
     [aktPartner setValue:[NSNumber numberWithInt:[[result valueForKey:@"partnerIsActive"] intValue] ] forKey:@"partnerIsActive"];
     [aktPartner setValue:[result valueForKey:@"partnerEmailcim"] forKey:@"partnerEmailcim"];
     [aktPartner setValue:[result valueForKey:@"partnerNev"] forKey:@"partnerNev"];
     [aktPartner setValue:[result valueForKey:@"partnerWeboldal"] forKey:@"partnerWeboldal"];
     [aktPartner setValue:[result valueForKey:@"partnerTelefonszam"] forKey:@"partnerTelefonszam"];
     [aktPartner setValue:[NSNumber numberWithFloat:[[result valueForKey:@"partnerXkoordinata"] floatValue] ] forKey:@"partnerXkoordinata"];
     [aktPartner setValue:[NSNumber numberWithFloat:[[result valueForKey:@"partnerYkoordinata"] floatValue] ] forKey:@"partnerYkoordinata"];
     [aktPartner setValue:[NSNumber numberWithInt:[[result valueForKey:@"partnerID"] intValue] ] forKey:@"partnerID"];
     }
    
    [self saveContext:context];
}

+ (void)fillMunkaTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Munka" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryMunkaTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     
     Munka* aktMunka = [NSEntityDescription
     insertNewObjectForEntityForName:@"Munka"
     inManagedObjectContext:context];
         
         if (![self IsEmpty:([result valueForKey:@"munkaID"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"munkaID"] intValue] ] forKey:@"munkaID"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkaDate"])]) {
             [aktMunka setValue:[result valueForKey:@"munkaDate"] forKey:@"munkaDate"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkaKoltseg"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"munkaKoltseg"] intValue] ] forKey:@"munkaKoltseg"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkaBevetel"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"munkaBevetel"] intValue] ] forKey:@"munkaBevetel"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkaUzemanyagState"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"munkaUzemanyagState"] intValue] ] forKey:@"munkaUzemanyagState"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkaComment"])]) {
             [aktMunka setValue:[result valueForKey:@"munkaComment"] forKey:@"munkaComment"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkaBefejezesDate"])]) {
             [aktMunka setValue:[result valueForKey:@"munkaBefejezesDate"] forKey:@"munkaBefejezesDate"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkaIsActive"])]) {
             [aktMunka setValue:[NSNumber numberWithBool:[[result valueForKey:@"munkaIsActive"] boolValue] ] forKey:@"munkaIsActive"];             
         }
         if (![self IsEmpty:([result valueForKey:@"munkaEstimatedTime"])]) {
             [aktMunka setValue:[result valueForKey:@"munkaEstimatedTime"] forKey:@"munkaEstimatedTime"];             
         }
         
         if (![self IsEmpty:([result valueForKey:@"soforID"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforID"] intValue] ] forKey:@"soforID"];
         }
         else {
             [aktMunka setValue:[NSNumber numberWithInt:0] forKey:@"soforID"];
         }
         
         if (![self IsEmpty:([result valueForKey:@"munkatipusID"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"munkatipusID"] intValue] ] forKey:@"munkatipusID"];
         }
         if (![self IsEmpty:([result valueForKey:@"telephelyID"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"telephelyID"] intValue] ] forKey:@"telephelyID"];
         }
         if (![self IsEmpty:([result valueForKey:@"partnerID"])]) {
             [aktMunka setValue:[NSNumber numberWithInt:[[result valueForKey:@"partnerID"] intValue] ] forKey:@"partnerID"];
         }                  
         
    }
    
    [self saveContext:context];
}

+ (void)fillMunkatipusTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Munkatipus" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryMunkaTipusTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     
     Munkatipus* aktMunkatipus = [NSEntityDescription
     insertNewObjectForEntityForName:@"Munkatipus"
     inManagedObjectContext:context];
         
         if (![self IsEmpty:([result valueForKey:@"munkatipusNev"])]) {
             [aktMunkatipus setValue:[result valueForKey:@"munkatipusNev"] forKey:@"munkatipusNev"];
         }
         if (![self IsEmpty:([result valueForKey:@"munkatipusID"])]) {
             [aktMunkatipus setValue:[NSNumber numberWithInt:[[result valueForKey:@"munkatipusID"] intValue] ] forKey:@"munkatipusID"];
         }    
     
     }
    [self saveContext:context];
}

+ (void)fillMunkaeszkozTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Munkaeszkoz" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryMunkaEszkozTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    /*
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     
     Telephely* aktTelephely = [NSEntityDescription
     insertNewObjectForEntityForName:@"Partner"
     inManagedObjectContext:context];
     
     [aktTelephely setValue:[result valueForKey:@"telephelyNev"] forKey:@"telephelyNev"];
     [aktTelephely setValue:[NSNumber numberWithInt:[[result valueForKey:@"telephelyIsActive"] intValue] ] forKey:@"telephelyIsActive"];
     [aktTelephely setValue:[result valueForKey:@"telephelyCim"] forKey:@"telephelyCim"];
     [aktTelephely setValue:[result valueForKey:@"telephelyTelefonszam"] forKey:@"telephelyTelefonszam"];
     [aktTelephely setValue:[result valueForKey:@"telephelyEmail"] forKey:@"telephelyEmail"];
     [aktTelephely setValue:[NSNumber numberWithFloat:[[result valueForKey:@"telephelyXkoordinata"] floatValue] ] forKey:@"telephelyXkoordinata"];
     [aktTelephely setValue:[NSNumber numberWithFloat:[[result valueForKey:@"telephelyYkoordinata"] floatValue] ] forKey:@"telephelyYkoordinata"];
     [aktTelephely setValue:[NSNumber numberWithInt:[[result valueForKey:@"telephelyID"] intValue] ] forKey:@"telephelyID"];
     
     }*/
    
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
        [aktAuto setValue:[NSNumber numberWithInt:[[result valueForKey:@"autoIsActive"] intValue] ] forKey:@"autoIsActive"];
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
    
    [self saveContext:context];
}

+ (void)fillProfilkepTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Profilkep" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryProfilkepTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     Profilkep* aktProfilkep = [NSEntityDescription
     insertNewObjectForEntityForName:@"Profilkep"
     inManagedObjectContext:context];
         
         if (![self IsEmpty:([result valueForKey:@"profilKepPath"])]) {
             [aktProfilkep setValue:[result valueForKey:@"profilKepPath"] forKey:@"profilKepPath"];
         }
         if (![self IsEmpty:([result valueForKey:@"profilKepID"])]) {
             [aktProfilkep setValue:[NSNumber numberWithInt:[[result valueForKey:@"profilKepID"] intValue] ] forKey:@"profilKepID"];
         }
         if (![self IsEmpty:([result valueForKey:@"profilKepDateTime"])]) {
             [aktProfilkep setValue:[result valueForKey:@"profilKepDateTime"] forKey:@"profilKepDateTime"];
         }
         if (![self IsEmpty:([result valueForKey:@"soforID"])]) {
             [aktProfilkep setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforID"] intValue] ] forKey:@"soforID"];
         }
     
     }
    
    [self saveContext:context];
}

+ (void)fillPartnerkepekTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Partnerkepek" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryPartnerKepekTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    /*
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     
     Sofor* aktsofor = [NSEntityDescription
     insertNewObjectForEntityForName:@"Sofor"
     inManagedObjectContext:context];
     
     [aktsofor setValue:[result valueForKey:@"soforNev"] forKey:@"soforNev"];
     [aktsofor setValue:[result valueForKey:@"soforLogin"] forKey:@"soforLogin"];
     [aktsofor setValue:[result valueForKey:@"soforPass"] forKey:@"soforPass"];
     [aktsofor setValue:[NSNumber numberWithBool:[[result valueForKey:@"soforIsActive"] boolValue] ] forKey:@"soforIsActive"];
     [aktsofor setValue:[NSNumber numberWithBool:[[result valueForKey:@"soforIsAdmin"] boolValue] ] forKey:@"soforIsAdmin"];
     [aktsofor setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforID"] intValue] ] forKey:@"soforID"];
     [aktsofor setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforProfilKepId"] intValue] ] forKey:@"soforProfilKepId"];
     [aktsofor setValue:[result valueForKey:@"soforBirthDate"] forKey:@"soforBirthDate"];
     [aktsofor setValue:[result valueForKey:@"soforCim"] forKey:@"soforCim"];
     [aktsofor setValue:[result valueForKey:@"soforEmail"] forKey:@"soforEmail"];
     [aktsofor setValue:[result valueForKey:@"soforRegTime"] forKey:@"soforRegTime"];
     [aktsofor setValue:[result valueForKey:@"soforTelefonszam"] forKey:@"soforTelefonszam"];
     }*/
    
    [self saveContext:context];
}

+ (void)fillMunkakepTable
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Munkakep" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/queryMunkaKepTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"];
    /*
     // Adatbázis feltöltése
     for (NSDictionary *result in rows) {
     
     Sofor* aktsofor = [NSEntityDescription
     insertNewObjectForEntityForName:@"Sofor"
     inManagedObjectContext:context];
     
     [aktsofor setValue:[result valueForKey:@"soforNev"] forKey:@"soforNev"];
     [aktsofor setValue:[result valueForKey:@"soforLogin"] forKey:@"soforLogin"];
     [aktsofor setValue:[result valueForKey:@"soforPass"] forKey:@"soforPass"];
     [aktsofor setValue:[NSNumber numberWithBool:[[result valueForKey:@"soforIsActive"] boolValue] ] forKey:@"soforIsActive"];
     [aktsofor setValue:[NSNumber numberWithBool:[[result valueForKey:@"soforIsAdmin"] boolValue] ] forKey:@"soforIsAdmin"];
     [aktsofor setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforID"] intValue] ] forKey:@"soforID"];
     [aktsofor setValue:[NSNumber numberWithInt:[[result valueForKey:@"soforProfilKepId"] intValue] ] forKey:@"soforProfilKepId"];
     [aktsofor setValue:[result valueForKey:@"soforBirthDate"] forKey:@"soforBirthDate"];
     [aktsofor setValue:[result valueForKey:@"soforCim"] forKey:@"soforCim"];
     [aktsofor setValue:[result valueForKey:@"soforEmail"] forKey:@"soforEmail"];
     [aktsofor setValue:[result valueForKey:@"soforRegTime"] forKey:@"soforRegTime"];
     [aktsofor setValue:[result valueForKey:@"soforTelefonszam"] forKey:@"soforTelefonszam"];
     }*/
    
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
        
        [aktTelephely setValue:[result valueForKey:@"telephelyNev"] forKey:@"telephelyNev"];
        [aktTelephely setValue:[NSNumber numberWithInt:[[result valueForKey:@"telephelyIsActive"] intValue] ] forKey:@"telephelyIsActive"];
        [aktTelephely setValue:[result valueForKey:@"telephelyCim"] forKey:@"telephelyCim"];
        [aktTelephely setValue:[result valueForKey:@"telephelyTelefonszam"] forKey:@"telephelyTelefonszam"];
        [aktTelephely setValue:[result valueForKey:@"telephelyEmail"] forKey:@"telephelyEmail"];
        
        [aktTelephely setValue:[NSNumber numberWithFloat:[[result valueForKey:@"telephelyXkoordinata"] floatValue] ] forKey:@"telephelyXkoordinata"];
        [aktTelephely setValue:[NSNumber numberWithFloat:[[result valueForKey:@"telephelyYkoordinata"] floatValue] ] forKey:@"telephelyYkoordinata"];
        [aktTelephely setValue:[NSNumber numberWithInt:[[result valueForKey:@"telephelyID"] intValue] ] forKey:@"telephelyID"];
        
    }
    
    [self saveContext:context];
}


+(void)autoFoglal:(NSString*) autoID :(NSNumber*) foglal
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    NSArray *lefoglalAuto = [self fetchRequestEntity:@"Auto" :@"autoID" :autoID];
    Auto * aktauto = [lefoglalAuto objectAtIndex:0];
    aktauto.autoFoglalt = [NSNumber numberWithInt:[foglal intValue]];
    if ([foglal boolValue])
    {
        aktauto.autoLastSoforID = [NSNumber numberWithInt:[[self aktUserID] intValue]];
    }
    else
    {
        aktauto.autoLastSoforID = [NSNumber numberWithInt:0];
    }
    
    foglaltautoID = autoID;
    [self saveContext:context];
}

+(BOOL)autoFoglal:(NSString*) autoID {
    NSArray *autok = [self fetchRequest:@"Auto" :@"1" :@"autoIsActive"];
    
    for (id aktauto in autok) {
        if ([[aktauto valueForKey:@"autoLastSoforID"] isEqualToNumber:[NSNumber numberWithInt:[[self aktUserID] intValue] ]])
        {
            NSLog(@"Van már rajtad auto, koccolj le!");
            foglaltautoID = [aktauto valueForKey:@"autoID"];
            return YES;
        }
    }
    return NO;
}

+(void)munkaFelvesz:(NSString*) munkaID
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    NSArray *munkafelvesz = [self fetchRequestEntity:@"Munka" :@"munkaID" :munkaID];
    Munka * aktmunka = [munkafelvesz objectAtIndex:0];
    aktmunka.soforID = [NSNumber numberWithInt:1];
    [self saveContext:context];
}


+(void)insertSofor:(NSNumber*) soforID : (NSString*) soforNev : (NSString*) soforCim : (NSString*) soforLogin : (NSString*) soforPass : (NSString*) soforTelefonszam : (NSString*) soforRegTime : (NSString*) soforBirthDate : (NSString*) soforEmail : (NSNumber*) soforIsAdmin : (NSNumber*) soforProfilKepId : (NSNumber*) soforIsActive
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    Sofor* newSofor = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Sofor"
                               inManagedObjectContext:context];
    
    [newSofor setValue:soforNev forKey:@"soforNev"];
    [newSofor setValue:soforLogin forKey:@"soforLogin"];
    [newSofor setValue:soforPass forKey:@"soforPass"];
    [newSofor setValue:[NSNumber numberWithBool:[soforIsActive boolValue]] forKey:@"soforIsActive"];
    [newSofor setValue:[NSNumber numberWithBool:[soforIsAdmin boolValue] ] forKey:@"soforIsAdmin"];
    [newSofor setValue:[NSNumber numberWithInt:[soforID intValue]] forKey:@"soforID"];
    [newSofor setValue:[NSNumber numberWithInt:[soforProfilKepId intValue]] forKey:@"soforProfilKepId"];
    [newSofor setValue:soforBirthDate forKey:@"soforBirthDate"];
    [newSofor setValue:soforCim forKey:@"soforCim"];
    [newSofor setValue:soforEmail forKey:@"soforEmail"];
    [newSofor setValue:soforRegTime forKey:@"soforRegTime"];
    [newSofor setValue:soforTelefonszam forKey:@"soforTelefonszam"];
    
    [self saveContext:context];
}



+(void)insertAuto:(NSNumber*) autoID : (NSString*) autoNev : (NSString*) autoRendszam : (NSString*) autoTipus : (NSString*) autoLastSzervizDate : (NSString*) autoLastUpDate : (NSString*) autoMuszakiVizsgaDate : (NSNumber*) autoKilometerOra : (NSNumber*) autoLastTelephelyID : (NSNumber*) autoUzemAnyag : (NSNumber*) autoXkoordinata : (NSNumber*) autoYkoordinata : (NSNumber*) autoProfilKepID
{
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    Auto* newAuto = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Auto"
                       inManagedObjectContext:context];
    
    
    // Üres sztring vizsgálatok kellenek még!!!!;
    [newAuto setValue:[NSNumber numberWithInt:[autoID intValue]] forKey:@"autoID"];
    [newAuto setValue:autoNev forKey:@"autoNev"];
    [newAuto setValue:[NSNumber numberWithInt:1] forKey:@"autoIsActive"];
    [newAuto setValue:[NSNumber numberWithInt:0] forKey:@"autoFoglalt"];
    [newAuto setValue:[NSNumber numberWithInt:0] forKey:@"autoLastSoforID"];
    [newAuto setValue:autoRendszam forKey:@"autoRendszam"];
    [newAuto setValue:autoTipus forKey:@"autoTipus"];
    [newAuto setValue:[NSNumber numberWithInt:[autoKilometerOra intValue]] forKey:@"autoKilometerOra"];
    [newAuto setValue:[NSNumber numberWithInt:[autoLastTelephelyID intValue]] forKey:@"autoLastTelephelyID"];
    [newAuto setValue:[NSNumber numberWithInt:[autoUzemAnyag intValue]] forKey:@"autoUzemAnyag"];
    [newAuto setValue:autoLastSzervizDate forKey:@"autoLastSzervizDate"];
    [newAuto setValue:autoLastUpDate forKey:@"autoLastUpDate"];
    [newAuto setValue:autoMuszakiVizsgaDate forKey:@"autoMuszakiVizsgaDate"];
    [newAuto setValue:[NSNumber numberWithInt:[autoProfilKepID intValue]] forKey:@"autoProfilKepID"];
    [newAuto setValue:[NSNumber numberWithDouble:[autoXkoordinata doubleValue]] forKey:@"autoXkoordinata"];
    [newAuto setValue:[NSNumber numberWithDouble:[autoYkoordinata doubleValue]] forKey:@"autoYkoordinata"];
    
    [self saveContext:context];
}


+ (NSNumber*)fetchRequestMaxID:(NSString*) entityName : (NSString*) sortName {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    
    //NSPredicate *Predicate = [NSPredicate predicateWithFormat:@"%K == %@", IDName, ID];
    
    NSSortDescriptor *sortDescriptors = [[NSSortDescriptor alloc] initWithKey:sortName  ascending:NO];
    
    
    //[fetchRequest setPredicate:Predicate];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptors]];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return [[fetchedObjects objectAtIndex:0] valueForKey:sortName];
}
+ (NSArray*)fetchRequestEntity:(NSString*) entityName : (NSString*) IDName :(NSString*) ID {
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    
    NSPredicate *Predicate = [NSPredicate predicateWithFormat:@"%K == %@", IDName, ID];
    
    [fetchRequest setPredicate:Predicate];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}


+(BOOL) IsInsert:(NSArray*) labels
{
    for (NSString* aktlabel in labels) {
        if ([self IsEmpty:aktlabel]) return NO;
    }
    return YES;
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