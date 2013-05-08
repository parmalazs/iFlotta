//
//  Munkaeszkoz.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
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
