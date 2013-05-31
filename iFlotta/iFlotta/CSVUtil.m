//
//  CSVUtil.m
//  iFlott
//
//  Created by  hallgato5 on 2013.05.31..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "CSVUtil.h"

@implementation CSVUtil
-(void)ArrayToCSV {
    NSArray *firstArray, *secondArray, *thirdArray;
    
    NSMutableString *csv = [NSMutableString stringWithString:@"Name,Date,Miles"];
    
    NSUInteger count = [firstArray count];
    // provided all arrays are of the same length
    for (NSUInteger i=0; i<count; i++ ) {
        [csv appendFormat:@"\n\"%@\",%@,\"%d\"",
         [firstArray objectAtIndex:i],
         [secondArray objectAtIndex:i],
         [[thirdArray objectAtIndex:i] integerValue]
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
