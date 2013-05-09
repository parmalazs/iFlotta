//
//  Munkakep.h
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Munka;

@interface Munkakep : NSManagedObject

@property (nonatomic, retain) NSNumber * munkaID;
@property (nonatomic, retain) NSString * munkaKepDate;
@property (nonatomic, retain) NSNumber * munkaKepID;
@property (nonatomic, retain) NSNumber * munkaKepIsUploaded;
@property (nonatomic, retain) NSString * munkaKepPath;
@property (nonatomic, retain) Munka *munka;

@end
