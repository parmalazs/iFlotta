//
//  ContactTabBarController.h
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDropdown.h"
@interface ContactTabBarController : UITabBarController  <DropdownDelegate>
{
    MBDropdown *dropdownSorted;
}
@end
