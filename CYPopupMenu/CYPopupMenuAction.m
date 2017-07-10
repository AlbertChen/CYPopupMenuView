//
//  PopupMenuItem.m
//  XCWXB
//
//  Created by Chen Yiliang on 10/28/16.
//  Copyright © 2016 Chen Yiliang. All rights reserved.
//

#import "CYPopupMenuAction.h"

@implementation CYPopupMenuAction

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName handler:(void (^)(CYPopupMenuAction *action, NSInteger selectedIndex))handler {
    self = [super init];
    if (self != nil) {
        self.title = title;
        self.iconName = iconName;
        self.handler = handler;
    }
    
    return self;
}

@end
