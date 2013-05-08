//
//  Profilkep.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sofor;

@interface Profilkep : NSManagedObject

@property (nonatomic, retain) NSString * profilKepDateTime;
@property (nonatomic, retain) NSNumber * profilKepID;
@property (nonatomic, retain) NSString * profilKepPath;
@property (nonatomic, retain) NSNumber * soforID;
@property (nonatomic, retain) NSNumber * profilKepIsUploaded;
@property (nonatomic, retain) Sofor *sofor;

@end
