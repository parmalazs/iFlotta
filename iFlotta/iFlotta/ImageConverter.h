//
//  ImageConverter.h
//  iFlott
//
//  Created by hallgato1 on 2013.06.01..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageConverter : NSObject
+ (NSString *)getStringFromImage:(UIImage *)image;
+ (UIImage*)imageFromMainBundleFile:(NSString*)aFileName;
@end
