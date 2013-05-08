//
//  Partner.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Munka, Partnerkepek;

@interface Partner : NSManagedObject

@property (nonatomic, retain) NSString * partnerCim;
@property (nonatomic, retain) NSString * partnerEmailcim;
@property (nonatomic, retain) NSNumber * partnerID;
@property (nonatomic, retain) NSString * partnerNev;
@property (nonatomic, retain) NSString * partnerTelefonszam;
@property (nonatomic, retain) NSString * partnerWeboldal;
@property (nonatomic, retain) NSNumber * partnerXkoordinata;
@property (nonatomic, retain) NSNumber * partnerYkoordinata;
@property (nonatomic, retain) Munka *munka;
@property (nonatomic, retain) NSSet *partnerkepek;
@end

@interface Partner (CoreDataGeneratedAccessors)

- (void)addPartnerkepekObject:(Partnerkepek *)value;
- (void)removePartnerkepekObject:(Partnerkepek *)value;
- (void)addPartnerkepek:(NSSet *)values;
- (void)removePartnerkepek:(NSSet *)values;

@end
