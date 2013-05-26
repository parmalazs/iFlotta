//
//  Telephely.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Auto, Munka;

@interface Telephely : NSManagedObject

@property (nonatomic, retain) NSString * telephelyCim;
@property (nonatomic, retain) NSString * telephelyEmail;
@property (nonatomic, retain) NSNumber * telephelyID;
@property (nonatomic, retain) NSString * telephelyNev;
@property (nonatomic, retain) NSString * telephelyTelefonszam;
@property (nonatomic, retain) NSNumber * telephelyXkoordinata;
@property (nonatomic, retain) NSNumber * telephelyYkoordinata;
@property (nonatomic, retain) NSNumber * telephelyIsActive;
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
