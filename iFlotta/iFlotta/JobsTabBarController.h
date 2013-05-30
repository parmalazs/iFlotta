//
//  JobsTabBarController.h
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDropdown.h"

@interface JobsTabBarController : UITabBarController <DropdownDelegate>
{
    MBDropdown *dropdownSorted;
}
@end
