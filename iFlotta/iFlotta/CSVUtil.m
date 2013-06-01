//
//  CSVUtil.m
//  iFlott
//
//  Created by  hallgato5 on 2013.05.31..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "CSVUtil.h"
#import "Partner.h"

@implementation CSVUtil
+(NSString*)PartnerToCSV:(NSArray *)nameArray : (NSArray *) phoneArray : (NSArray *) emailArray {
    
    NSMutableString *csv = [[NSMutableString alloc] init];
    
    
    NSUInteger count = [nameArray count];
    // provided all arrays are of the same length
    for (NSUInteger i=0; i<count; i++ ) {
        [csv appendFormat:@"\n\"%@\",%@,\"%@\"",
         [nameArray objectAtIndex:i],
         [phoneArray objectAtIndex:i],
         [emailArray objectAtIndex:i]
         ];
        // instead of integerValue may be used intValue or other, it depends how array was created
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: @"partners.csv"];
    
    NSError *error;
    BOOL res = [csv writeToFile:docFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!res) {
        NSLog(@"Error %@ while writing to file %@", [error localizedDescription], docFile );
    }
    NSLog(csv);
    
    return docFile;
}

+(NSString*)SoforToCSV:(NSArray *)nameArray : (NSArray *) phoneArray : (NSArray *) emailArray {
    
    NSMutableString *csvDriver = [[NSMutableString alloc] init];
    
    
    NSUInteger count = [nameArray count];
    // provided all arrays are of the same length
    for (NSUInteger i=0; i<count; i++ ) {
        [csvDriver appendFormat:@"\n\"%@\",%@,\"%@\"",
         [nameArray objectAtIndex:i],
         [phoneArray objectAtIndex:i],
         [emailArray objectAtIndex:i]
         ];
        // instead of integerValue may be used intValue or other, it depends how array was created
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: @"drivers.csv"];
    
    NSError *error;
    BOOL res = [csvDriver writeToFile:docFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!res) {
        NSLog(@"Error %@ while writing to file %@", [error localizedDescription], docFile );
    }
    NSLog(csvDriver);
    
    return docFile;
}
@end
