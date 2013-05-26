//
//  Munkaeszkoz.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Munka;

@interface Munkaeszkoz : NSManagedObject

@property (nonatomic, retain) NSNumber * munkaEszkozAr;
@property (nonatomic, retain) NSNumber * munkaEszkozID;
@property (nonatomic, retain) NSString * munkaEszkozNev;
@property (nonatomic, retain) NSNumber * munkaID;
@property (nonatomic, retain) Munka *munka;

@end
