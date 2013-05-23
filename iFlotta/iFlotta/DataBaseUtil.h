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
+ (NSArray*)fetchRequest:(NSString*) entityName;
+ (void)fillSoforTable;
+ (void)fillTelephelyTable;
+ (void)fillAutoTable;
+ (BOOL) IsEmpty:(id) thing;
@end
