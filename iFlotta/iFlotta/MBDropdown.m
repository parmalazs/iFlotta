//
//  MBDropdown.m
//  MB Dropdown
//
//  Created by Michael Sanchez on 1/21/13.
//  Copyright (c) 2013 Michael Sanchez. All rights reserved.
//  https://github.com/msanchez1701/MB-Dropdown

#import "MBDropdown.h"

@implementation MBDropdown

#define dropdownHeight 200

- (id)initWithPresentingView:(UIView *)view andItems:(NSArray *)items delegate:(id)delegate kezdpoz:(NSNumber*) kp{
    self = [super init];
    if (self){
        _barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showDropdown:)];
        presentingView = view;
        presentingDelegate = delegate;
        [self setFrame:CGRectMake(160, [kp floatValue], 150, dropdownHeight)];

        
        CAGradientLayer *headerLayer = [CAGradientLayer layer];
        [headerLayer setColors:@[(id)[[UIColor blackColor] CGColor],(id)[[UIColor grayColor] CGColor]]];
        [headerLayer setFrame:self.bounds];
        [headerLayer setCornerRadius:10];
        [self.layer insertSublayer:headerLayer atIndex:0];
        [self setAlpha:0];
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 140, dropdownHeight-10) style:UITableViewStylePlain];
        [mainTableView setDelegate:self];
        [mainTableView setDataSource:self];
        [mainTableView.layer setCornerRadius:5];
        [self addSubview:mainTableView];
        allItems = [[NSArray alloc] initWithArray:items];
    }
    return self;
}
- (id)initWithPresentingView:(UIView *)view andItems:(NSArray *)items withHeight:(CGFloat)height delegate:(id)delegate{
    self = [super init];
    if (self){
        _barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showDropdown:)];
        presentingView = view;
        presentingDelegate = delegate;
        [self setFrame:CGRectMake(160, 10, 150, height)];
        
        
        CAGradientLayer *headerLayer = [CAGradientLayer layer];
        [headerLayer setColors:@[(id)[[UIColor blackColor] CGColor],(id)[[UIColor grayColor] CGColor]]];
        [headerLayer setFrame:self.bounds];
        [headerLayer setCornerRadius:10];
        [self.layer insertSublayer:headerLayer atIndex:0];
        [self setAlpha:0];
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 140, height-10) style:UITableViewStylePlain];
        [mainTableView setDelegate:self];
        [mainTableView setDataSource:self];
        [mainTableView.layer setCornerRadius:5];
        [self addSubview:mainTableView];
        allItems = [[NSArray alloc] initWithArray:items];
    }
    return self;
}
- (IBAction)showDropdown:(id)sender{
    if (!isShowing){
        [presentingView addSubview:self];
        [UIView animateWithDuration:.5 animations:^{
            [self setAlpha:1];
        }completion:^(BOOL finished) {
            isShowing = YES;
        }];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            [self setAlpha:0];
        }completion:^(BOOL finished) {
            isShowing = NO;
        }];
    }
}
- (void)dismiss{
    if (isShowing){
        [UIView animateWithDuration:.5 animations:^{
            [self setAlpha:0];
        }completion:^(BOOL finished) {
            isShowing = NO;
        }];
    }
}
#pragma mark - TableView Datasource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [allItems count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *item = [allItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item objectForKey:@"name"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamed:[item objectForKey:@"image"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *itemSelected = [[NSMutableDictionary alloc] initWithDictionary:[allItems objectAtIndex:indexPath.row]];
    [itemSelected setObject:indexPath forKey:@"row"];
    [presentingDelegate didSelectItem:itemSelected];
}

@end