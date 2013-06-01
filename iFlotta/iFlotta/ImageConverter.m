//
//  ImageConverter.m
//  iFlott
//
//  Created by hallgato1 on 2013.06.01..
//  Copyright (c) 2013 Csüti. All rights reserved.
//
#import "NSDataAdditions.h"
#import "ImageConverter.h"

@implementation ImageConverter
+(NSString *)getStringFromImage:(UIImage *)image{
	if(image){
		NSData *dataObj = UIImagePNGRepresentation(image);
		NSString * ret = [dataObj base64Encoding];
        //ret = [ret stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        return ret;
	} else {
		return @"ROSYY KEP";
	}
}

+ (UIImage*)imageFromMainBundleFile:(NSString*)aFileName; {
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    NSLog(@"PATH: %@/%@",bundlePath,aFileName);
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath,aFileName]];
}

@end
