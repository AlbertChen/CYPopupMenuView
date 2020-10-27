//
//  CYPopupMenuView.m
//  XCWXB
//
//  Created by Chen Yiliang on 10/28/16.
//  Copyright © 2016 Chen Yiliang. All rights reserved.
//

#import "CYPopupMenuView.h"
#import "CYPopupMenuOverlayView.h"

static const NSTimeInterval kPopupMenuAnimationDuration = 0.2;

@interface CYPopupMenuView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, weak) CYPopupMenuOverlayView *overlayView;

@property (nonatomic, strong) NSArray *menuActions;

@end

@implementation CYPopupMenuView

#pragma mark - Geters/Seters

- (BOOL)isVisible {
    return self.superview != nil;
}

- (void)setArrowDirection:(PopupMenuArrowDirection)arrowDirection {
    _arrowDirection = arrowDirection;
    
    CGSize shadowOffset = self.shadowView.layer.shadowOffset;
    switch (arrowDirection) {
        case PopupMenuArrowDirectionUp:
            shadowOffset = CGSizeMake(0.0, 1.0);
            break;
        case PopupMenuArrowDirectionDown:
            shadowOffset = CGSizeMake(0.0, -1.0);
            break;
        case PopupMenuArrowDirectionLeft:
            shadowOffset = CGSizeMake(1.0, 0.0);
            break;
        case PopupMenuArrowDirectionRight:
            shadowOffset = CGSizeMake(-1.0, 0.0);
            break;
    }
    self.shadowView.layer.shadowOffset = shadowOffset;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.layer.cornerRadius = 3.0;
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    return _tableView;
}

- (UIView *)shadowView {
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] initWithFrame:self.bounds];
        _shadowView.translatesAutoresizingMaskIntoConstraints = NO;
        _shadowView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.1];
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOpacity = 1.0;
        _shadowView.layer.shadowRadius = 1.0;
        _shadowView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    }
    
    return _shadowView;
}

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame menuActions:(NSArray *)menuActions {
    
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.menuActions = menuActions;
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    [self addSubview:self.shadowView];
    [self addSubview:self.tableView];
    [self setupLayoutConstraints];
    
    self.backgroundColor = [UIColor clearColor];
    self.arrowDirection = PopupMenuArrowDirectionUp;
}

- (void)setupLayoutConstraints {
    NSDictionary *views = @ { @"tableView": self.tableView, @"shadowView": self.shadowView };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[shadowView]-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[shadowView]-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" options:0 metrics:nil views:views]];
}

- (void)drawRect:(CGRect)rect {
    [self drawArrowInRect:self.arrowRect direction:self.arrowDirection];
}

#pragma mark - Drawing

- (CGMutablePathRef)arrowPathInRect:(CGRect)rect direction:(PopupMenuArrowDirection)direction {
    // Create arrow path
    CGMutablePathRef path = CGPathCreateMutable();
    
    switch (direction) {
        case PopupMenuArrowDirectionDown:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height);
            CGPathCloseSubpath(path);
        }
            break;
            
        case PopupMenuArrowDirectionUp:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width / 2.0, rect.origin.y);
            CGPathCloseSubpath(path);
        }
            break;
            
        case PopupMenuArrowDirectionLeft:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height / 2.0);
            CGPathCloseSubpath(path);
        }
            break;
            
        case PopupMenuArrowDirectionRight:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2.0);
            CGPathCloseSubpath(path);
        }
            break;
            
        default:
            break;
    }
    
    return path;
}

- (void)drawArrowInRect:(CGRect)rect direction:(PopupMenuArrowDirection)direction {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Arrow
    CGContextSaveGState(context); {
        CGMutablePathRef path = [self arrowPathInRect:rect direction:direction];
        CGContextAddPath(context, path);
        
//        UIColor *color = highlighted ? self.highlightedColor : self.color;
        UIColor *color = [UIColor whiteColor];
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillPath(context);
        
        CGPathRelease(path);
    } CGContextRestoreGState(context);
}

#pragma mark - Actions

- (IBAction)backgroundViewTapped:(id)sender {
    [self dismissAnimated:YES];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
    if (self.visible) {
        return;
    }
    
    CYPopupMenuOverlayView *overlayView = [[CYPopupMenuOverlayView alloc] initWithFrame:view.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.menuView = self;
    [view addSubview:overlayView];
    self.overlayView = overlayView;
    
    [view addSubview:self];
    
    if (animated) {
        self.alpha = 0;
        [UIView animateWithDuration:kPopupMenuAnimationDuration animations:^(void) {
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)dismissAnimated:(BOOL)animated
{
    if (!self.visible) {
        return;
    }
    
    if (animated) {
        [UIView animateWithDuration:kPopupMenuAnimationDuration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self.overlayView removeFromSuperview];
            [self removeFromSuperview];
        }];
    } else {
        [self.overlayView removeFromSuperview];
        [self removeFromSuperview];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuActions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    CYPopupMenuAction *action = self.menuActions[indexPath.row];
    cell.textLabel.text = action.title;
    cell.textLabel.textColor = action.titleColor;
    cell.imageView.image = action.iconName != nil ? [UIImage imageNamed:action.iconName] : nil;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CYPopupMenuAction *action = self.menuActions[indexPath.row];
    if (action.handler != nil) {
        action.handler(action, indexPath.row);
    }
    
    [self dismissAnimated:YES];
}

@end
