//
//  Sofor.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Auto, Munka, Profilkep;

@interface Sofor : NSManagedObject

@property (nonatomic, retain) NSString * soforBirthDate;
@property (nonatomic, retain) NSString * soforCim;
@property (nonatomic, retain) NSString * soforEmail;
@property (nonatomic, retain) NSNumber * soforID;
@property (nonatomic, retain) NSNumber * soforIsAdmin;
@property (nonatomic, retain) NSString * soforLogin;
@property (nonatomic, retain) NSString * soforNev;
@property (nonatomic, retain) NSString * soforPass;
@property (nonatomic, retain) NSNumber * soforProfilKepId;
@property (nonatomic, retain) NSString * soforRegTime;
@property (nonatomic, retain) NSString * soforTelefonszam;
@property (nonatomic, retain) NSNumber * soforIsActive;
@property (nonatomic, retain) Auto *autoRelationship;
@property (nonatomic, retain) Munka *munka;
@property (nonatomic, retain) NSSet *profilkep;
@end

@interface Sofor (CoreDataGeneratedAccessors)

- (void)addProfilkepObject:(Profilkep *)value;
- (void)removeProfilkepObject:(Profilkep *)value;
- (void)addProfilkep:(NSSet *)values;
- (void)removeProfilkep:(NSSet *)values;

@end
