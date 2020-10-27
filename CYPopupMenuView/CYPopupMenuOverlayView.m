//
//  PopupMenuOverlayerView.m
//  XCWXB
//
//  Created by Chen Yiliang on 11/8/16.
//  Copyright © 2016 Chen Yiliang. All rights reserved.
//

#import "CYPopupMenuOverlayView.h"
#import "CYPopupMenuView.h"

@implementation CYPopupMenuOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        [self.menuView dismissAnimated:YES];
    }
}

@end
