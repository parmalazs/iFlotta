//
//  Telephely.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Auto, Munka;

@interface Telephely : NSManagedObject

@property (nonatomic, retain) NSString * telephelyCim;
@property (nonatomic, retain) NSString * telephelyEmail;
@property (nonatomic, retain) NSString * telephelyID;
@property (nonatomic, retain) NSString * telephelyNev;
@property (nonatomic, retain) NSString * telephelyTelefonszam;
@property (nonatomic, retain) NSNumber * telephelyXkoordinata;
@property (nonatomic, retain) NSNumber * telephelyYkoordinata;
@property (nonatomic, retain) NSSet *autoRelationship;
@property (nonatomic, retain) NSSet *munka;
@end

@interface Telephely (CoreDataGeneratedAccessors)

- (void)addAutoRelationshipObject:(Auto *)value;
- (void)removeAutoRelationshipObject:(Auto *)value;
- (void)addAutoRelationship:(NSSet *)values;
- (void)removeAutoRelationship:(NSSet *)values;

- (void)addMunkaObject:(Munka *)value;
- (void)removeMunkaObject:(Munka *)value;
- (void)addMunka:(NSSet *)values;
- (void)removeMunka:(NSSet *)values;

@end
