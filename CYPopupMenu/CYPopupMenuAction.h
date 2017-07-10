//
//  PopupMenuItem.h
//  XCWXB
//
//  Created by Chen Yiliang on 10/28/16.
//  Copyright © 2016 Chen Yiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CYPopupMenuAction : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, copy) void (^handler)(CYPopupMenuAction *action, NSInteger selectedIndex);

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName handler:(void (^)(CYPopupMenuAction *action, NSInteger selectedIndex))handler;

@end
