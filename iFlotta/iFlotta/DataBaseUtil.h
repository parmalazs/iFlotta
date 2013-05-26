//
//  DataBaseUtil.h
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseUtil : NSObject
+ (void) deleteAllObjects: (NSString *) entityDescription  :(NSManagedObjectContext*) context;
+ (void)saveContext:(NSManagedObjectContext *)managedObjectContext;
+ (NSArray*)fetchRequestJarmu:(NSString*) entityName :(NSString*) IsActive :(NSString*) IsActiveName :(NSString*) tipusName;
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
+ (BOOL) IsEmpty:(id) thing;
@end