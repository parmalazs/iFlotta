//
//  DataBaseUtil.h
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sofor.h"


@interface DataBaseUtil : NSObject
+ (void) deleteAllObjects: (NSString *) entityDescription  :(NSManagedObjectContext*) context;
+ (void)saveContext:(NSManagedObjectContext *)managedObjectContext;
+ (NSArray*)fetchRequest:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) sortName :(NSNumber*) sortType;
+ (NSArray*)fetchRequestJarmu:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) tipusName :(NSString*) sortName :(NSNumber*) sortType;
+ (NSArray*)fetchRequestJarmu:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) tipusName;
+ (NSArray*)fetchRequestSzabadMunka:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSNumber*) soforID;
+ (NSArray*)fetchRequestSzabadMunka:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) soforID :(NSString*) sortName :(NSNumber*) sortType;
+ (NSArray*)fetchRequest:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName ;
+ (NSArray*)fetchAllRequest:(NSString*) entityName;
+ (void)fillSoforTable;
+ (void)fillAutokepTable;
+ (void)fillPartnerTable;
+ (void)fillTelephelyTable;
+ (void)fillMunkatipusTable;
+ (void)fillMunkaTable;
+ (void)fillMunkaeszkozTable;
+ (void)fillPartnerkepekTable;
+ (void)fillProfilkepTable;
+ (void)fillMunkakepTable;
+ (void)fillAutoTable;
+(void) setUser:(NSString*)admin :(NSString*)userid;
+ (NSString*)aktUserAdmin;
+ (NSString*)aktUserID;
+ (BOOL) IsEmpty:(id) thing;
+ (NSArray*)fetchRequestEntity:(NSString*) entityName : (NSString*) IDName :(NSString*) ID;
+ (NSNumber*)fetchRequestMaxID:(NSString*) entityName : (NSString*) sortName;

+(void)insertSofor:(NSNumber*) soforID : (NSString*) soforNev : (NSString*) soforCim : (NSString*) soforLogin : (NSString*) soforPass : (NSString*) soforTelefonszam : (NSString*) soforRegTime : (NSString*) soforBirthDate : (NSString*) soforEmail : (NSNumber*) soforIsAdmin : (NSNumber*) soforProfilKepId : (NSNumber*) soforIsActive;
@end