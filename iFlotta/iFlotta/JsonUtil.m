//
//  JsonUtil.m
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "JsonUtil.h"


@implementation JsonUtil
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(void)getJson {
    
    NSMutableDictionary* object = [[NSMutableDictionary alloc] init];
    
    
    [object setObject:@"iOS" forKey:@"soforPass"];
    [object setObject:@"iOS" forKey:@"soforNev"];
    [object setObject:@"323" forKey:@"soforID"];
    [object setObject:@"iOS" forKey:@"soforCim"];
    [object setObject:@"iOS" forKey:@"soforLogin"];
    [object setObject:@"iOS" forKey:@"soforRegTime"];
    [object setObject:@"iOS" forKey:@"soforBirthDate"];
    [object setObject:@"iOS" forKey:@"soforEmail"];
    [object setObject:@"iOS" forKey:@"soforTelefonszam"];
    [object setObject:@"1" forKey:@"soforIsAdmin"];
    [object setObject:@"2" forKey:@"soforProfilKepID"];
    //[object setObject:@"1" forKey:@"soforIsActive"];
    
    NSMutableDictionary* json = [[NSMutableDictionary alloc] init];
    

    [json setObject:object forKey:@"objects"];
    [json setObject:@"insert" forKey:@"action"];
    [json setObject:@"sofor" forKey:@"tableName"];

    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    

    NSString *js = [[NSString alloc] initWithString:(@"%@",jsonString)];
    
    NSLog(@" %@",js);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://www.flotta.host-ed.me/index.php"]];
    /*
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-type"];
      
    [request setValue:[NSString stringWithFormat:@"%d",
                       [js length]]
     
    forHTTPHeaderField:@"Content-length"];
    
    [request setHTTPBody:[js
                          dataUsingEncoding:NSUTF8StringEncoding]];
    
     [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
    
    
    
    NSData *requestData = [NSData dataWithBytes:[js UTF8String] length:[js length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        NSLog(@"Válasz");
    }
    
    
    //return jsonString;
}
@end
