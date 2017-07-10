//
//  ViewController.m
//  PopupMenuViewDemo
//
//  Created by Chen Yiliang on 4/28/17.
//  Copyright © 2017 Chen Yiliang. All rights reserved.
//

#import "ViewController.h"
#import "CYPopupMenuView.h"

static inline CGSize screenSize() {
    return [UIScreen mainScreen].bounds.size;
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
}

#pragma mark - Actions

- (IBAction)menuButtonPressed:(id)sender {
    NSArray *actions = [self menuActions:NO];
    CGRect frame = CGRectMake(screenSize().width - 160, 54, 160, 40 * actions.count + 15);
    CYPopupMenuView *menuView = [[CYPopupMenuView alloc] initWithFrame:frame menuActions:actions];
    menuView.arrowRect = CGRectMake(160 - 35, 0, 10, 10);
    
    [menuView showInView:self.navigationController.view animated:YES];
}

- (IBAction)leftButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    CGRect buttonFrame = [self.view convertRect:button.frame toView:self.navigationController.view];
    NSArray *actions = [self menuActions:YES];
    CGFloat height = 40 * actions.count + 15;
    CGRect frame = CGRectMake(CGRectGetMaxX(buttonFrame), CGRectGetMidY(buttonFrame) - (height / 2), 160, height);
    CYPopupMenuView *menuView = [[CYPopupMenuView alloc] initWithFrame:frame menuActions:actions];
    menuView.arrowRect = CGRectMake(0, (height - 10) / 2, 10, 10);
    menuView.arrowDirection = PopupMenuArrowDirectionLeft;
    
    [menuView showInView:self.navigationController.view animated:YES];
}

- (IBAction)middleToolButtonPressed:(id)sender {
    NSArray *actions = [self menuActions:YES];
    CGFloat height = 40 * actions.count + 15;
    CGRect frame = CGRectMake((screenSize().width - 160) / 2, screenSize().height - height - 40, 160, height);
    CYPopupMenuView *menuView = [[CYPopupMenuView alloc] initWithFrame:frame menuActions:actions];
    menuView.arrowRect = CGRectMake((160 - 10) / 2, height - 10, 10, 10);
    menuView.arrowDirection = PopupMenuArrowDirectionDown;
    
    [menuView showInView:self.navigationController.view animated:YES];
}

#pragma mark -

- (NSArray *)menuActions:(BOOL)hasIcon {
    if (hasIcon) {
        CYPopupMenuAction *unarchiveAction = [[CYPopupMenuAction alloc] initWithTitle:@"撤档" iconName:@"icon_archive2" handler:^(CYPopupMenuAction *action, NSInteger selectedIndex) {
            NSLog(@"撤档");
        }];
        unarchiveAction.titleColor = [UIColor colorWithRed:245/255.0 green:115/255.0 blue:111/255.0 alpha:1.0];
        
        CYPopupMenuAction *editAction = [[CYPopupMenuAction alloc] initWithTitle:@"编辑" iconName:@"icon_write_3" handler:^(CYPopupMenuAction *action, NSInteger selectedIndex) {
            NSLog(@"编辑");
        }];
        
        CYPopupMenuAction *lockAction = [[CYPopupMenuAction alloc] initWithTitle:@"锁定" iconName:@"icon_unlock" handler:^(CYPopupMenuAction *action, NSInteger selectedIndex) {
            NSLog(@"锁定");
        }];
        
        return @[unarchiveAction, editAction, lockAction];
    } else {
        CYPopupMenuAction *archiveAction = [[CYPopupMenuAction alloc] initWithTitle:@"归档" iconName:nil handler:^(CYPopupMenuAction *action, NSInteger selectedIndex) {
            NSLog(@"归档");
        }];
        
        CYPopupMenuAction *unlockAction = [[CYPopupMenuAction alloc] initWithTitle:@"解锁" iconName:nil handler:^(CYPopupMenuAction *action, NSInteger selectedIndex) {
            NSLog(@"解锁");
        }];
        unlockAction.titleColor = [UIColor colorWithRed:245/255.0 green:115/255.0 blue:111/255.0 alpha:1.0];
        
        CYPopupMenuAction *deleteAction = [[CYPopupMenuAction alloc] initWithTitle:@"删除" iconName:nil handler:^(CYPopupMenuAction *action, NSInteger selectedIndex) {
            NSLog(@"删除");
        }];
        
        return @[archiveAction, unlockAction, deleteAction];
    }
}

@end
