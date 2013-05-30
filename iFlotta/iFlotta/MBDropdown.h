//
//  MBDropdown.h
//  MB Dropdown
//
//  Created by Michael Sanchez on 1/21/13.
//  Copyright (c) 2013 Michael Sanchez. All rights reserved.
//  https://github.com/msanchez1701/MB-Dropdown

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol DropdownDelegate;

@interface MBDropdown : UIView <UITableViewDataSource, UITableViewDelegate> {
    @private
    UIView *presentingView;
    UITableView *mainTableView;
    BOOL isShowing;
    id presentingDelegate;
    NSArray *allItems;
}
@property (nonatomic, strong)UIBarButtonItem *barButton;
- (id)initWithPresentingView:(UIView *)view andItems:(NSArray *)items delegate:(id)delegate kezdpoz:(NSNumber*) kp;
- (id)initWithPresentingView:(UIView *)view andItems:(NSArray *)items withHeight:(CGFloat)height delegate:(id)delegate;
- (IBAction)showDropdown:(id)sender;
- (void)dismiss;
@end

@protocol DropdownDelegate <NSObject>
@required
- (void)didSelectItem:(NSDictionary *)item;
@end
