//
//  Autokep.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Auto;

@interface Autokep : NSManagedObject

@property (nonatomic, retain) NSNumber * autoID;
@property (nonatomic, retain) NSString * autoKepDateTime;
@property (nonatomic, retain) NSNumber * autoKepID;
@property (nonatomic, retain) NSString * autoKepPath;
@property (nonatomic, retain) NSNumber * autoKepIsUploaded;
@property (nonatomic, retain) Auto *autoRelationship;

@end
