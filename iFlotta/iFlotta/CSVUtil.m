//
//  CSVUtil.m
//  iFlott
//
//  Created by  hallgato5 on 2013.05.31..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "CSVUtil.h"

@implementation CSVUtil
-(void)ArrayToCSV:(NSArray *)nameArray : (NSArray *) phoneArray : (NSArray *) emailArray {
    
    NSMutableString *csv = [NSMutableString stringWithString:@"Name,Phone,Email"];
    
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
    
    NSString *yourFileName = @"your filename";
    NSError *error;
    BOOL res = [csv writeToFile:yourFileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!res) {
        NSLog(@"Error %@ while writing to file %@", [error localizedDescription], yourFileName );
    }
}
@end
