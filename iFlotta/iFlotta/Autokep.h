//
//  Autokep.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Auto;

@interface Autokep : NSManagedObject

@property (nonatomic, retain) NSNumber * autoID;
@property (nonatomic, retain) NSString * autoKepDateTime;
@property (nonatomic, retain) NSNumber * autoKepID;
@property (nonatomic, retain) NSNumber * autoKepIsUploaded;
@property (nonatomic, retain) NSString * autoKepPath;
@property (nonatomic, retain) NSNumber * autoKepIsActive;
@property (nonatomic, retain) Auto *autoRelationship;

@end
