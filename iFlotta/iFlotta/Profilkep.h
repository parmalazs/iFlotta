//
//  Profilkep.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sofor;

@interface Profilkep : NSManagedObject

@property (nonatomic, retain) NSString * profilKepDateTime;
@property (nonatomic, retain) NSNumber * profilKepID;
@property (nonatomic, retain) NSNumber * profilKepIsUploaded;
@property (nonatomic, retain) NSString * profilKepPath;
@property (nonatomic, retain) NSNumber * soforID;
@property (nonatomic, retain) NSNumber * profilKepIsActive;
@property (nonatomic, retain) Sofor *sofor;

@end
