//
//  Munkakep.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Munka;

@interface Munkakep : NSManagedObject

@property (nonatomic, retain) NSNumber * munkaID;
@property (nonatomic, retain) NSString * munkaKepDate;
@property (nonatomic, retain) NSNumber * munkaKepID;
@property (nonatomic, retain) NSString * munkaKepPath;
@property (nonatomic, retain) NSNumber * munkaKepIsUploaded;
@property (nonatomic, retain) Munka *munka;

@end
