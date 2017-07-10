//
//  CYPopupMenuView.h
//  XCWXB
//
//  Created by Chen Yiliang on 10/28/16.
//  Copyright © 2016 Chen Yiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPopupMenuAction.h"

typedef NS_ENUM(NSInteger, PopupMenuArrowDirection) {
    PopupMenuArrowDirectionUp = 0,
    PopupMenuArrowDirectionDown,
    PopupMenuArrowDirectionLeft,
    PopupMenuArrowDirectionRight
};

@interface CYPopupMenuView : UIView

@property (nonatomic, assign, getter = isVisible, readonly) BOOL visible;
@property (nonatomic, assign) CGRect arrowRect;
@property (nonatomic, assign) PopupMenuArrowDirection arrowDirection;

- (instancetype)initWithFrame:(CGRect)frame menuActions:(NSArray *)menuActions;

- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;

- (CGMutablePathRef)arrowPathInRect:(CGRect)rect direction:(PopupMenuArrowDirection)direction CF_RETURNS_RETAINED;
- (void)drawArrowInRect:(CGRect)rect direction:(PopupMenuArrowDirection)direction;

@end
