//
//  ImageSender.m
//  iFlott
//
//  Created by hallgato1 on 2013.06.01..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "ImageSender.h"

@implementation ImageSender
+(void)sendImg:(NSMutableDictionary*) img
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:img options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://www.flotta.host-ed.me/imgUploadX.php"]];
    
    // NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    NSData *requestData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody: requestData];
    
    
    //NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&error];
    //[request setHTTPBody:data];
    NSLog(@"Válasz1: %@", data);
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Válasz2: %@", string);
}

@end
