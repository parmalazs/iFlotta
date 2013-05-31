//
//  JarmuTabBarController.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDropdown.h"

@interface JarmuTabBarController : UITabBarController <DropdownDelegate, UITabBarControllerDelegate>
{
    MBDropdown *dropdownSorted;
}
@end
