//
//  SRMModalViewController.m
//  Example
//
//  Created by marksong on 3/25/16.
//  Copyright © 2016 S.R. All rights reserved.
//

#import "SRMModalViewController.h"

@interface SRMModalViewController ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIViewController *contentViewController;

@end

@implementation SRMModalViewController

#pragma mark Override

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor blackColor];
        self.backgroundOpacity = 0.4;
        self.enableTapOutsideToDismiss = YES;
        self.shouldRotate = YES;
        self.showingAnimationStyle = SRMShowingAnimationStyleDefault;
        self.hidingAnimationStyle = SRMHidingAnimationStyleDefault;
    }
    
    return self;
}

#pragma mark Public

- (void)showViewWithController:(UIViewController *)viewController {
    self.contentViewController = viewController;
    [self showView:viewController.view];
}

- (void)showView:(UIView *)view {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.containerView];
    [self constraintsForFillingInSuperViewOfView:self.containerView];
    [self.containerView addSubview:view];
    [self constraintsForCenterInSuperViewOfView:view];
    self.contentView = view;
    
    // Keep reference of self.
    if ([self shouldRetainSelf]) {
        [[[self class] instanceArray] addObject:self];
    }
    
    switch (self.showingAnimationStyle) {
        case SRMShowingAnimationStyleDefault:
            [self showingWithAnimationStyleDefault];
            break;
        default:
            break;
    }
}

- (void)hide {
    switch (self.hidingAnimationStyle) {
        case SRMHidingAnimationStyleDefault:
            [self hidingWithAnimationStyleDefault];
            break;
        default:
            [self clear];
            break;
    }
}

#pragma mark Private

+ (NSMutableArray *)instanceArray {
    static NSMutableArray *instanceArray;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instanceArray = [NSMutableArray array];
    });
    
    return instanceArray;
}

- (BOOL)shouldRetainSelf {
    // When tap gesture is enabled or show a view with controller, need to keep reference of self, in case that self is a local instance of user.
    return self.enableTapOutsideToDismiss || self.contentViewController;
}

- (void)clear {
    [self.containerView removeFromSuperview];
    
    // Remove reference of self.
    if ([self shouldRetainSelf]) {
        [[[self class] instanceArray] removeObject:self];
    }
}

- (void)showingWithAnimationStyleDefault {
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    }];
}

- (void)hidingWithAnimationStyleDefault {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        [self clear];
    }];
}

- (void)constraintsForFillingInSuperViewOfView:(UIView *)contentView {
    // Content view should be added to super view firstly.
    if (!contentView.superview) {
        return;
    }
    
    static NSString *viewKey = @"view";
    
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *horizontalConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|", viewKey] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{viewKey:contentView}];
    NSArray *verticalConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", viewKey] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{viewKey:contentView}];
    NSMutableArray *constraintArray = [NSMutableArray new];
    [constraintArray addObjectsFromArray:horizontalConstraintArray];
    [constraintArray addObjectsFromArray:verticalConstraintArray];
    [contentView.superview addConstraints:constraintArray];
}

- (void)constraintsForCenterInSuperViewOfView:(UIView *)contentView {
    // Content view should be added to super view firstly.
    if (!contentView.superview) {
        return;
    }
    
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetWidth(contentView.frame)];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetHeight(contentView.frame)];
    NSLayoutConstraint *horizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:contentView.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *verticalCenterConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentView.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSArray *constraintArray = @[horizontalCenterConstraint, verticalCenterConstraint, widthConstraint, heightConstraint];
    [contentView.superview addConstraints:constraintArray];
}

#pragma mark Getter

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        // Add background view
        UIView *backgroundView = [UIView new];
        backgroundView.backgroundColor = self.backgroundColor;
        backgroundView.alpha = self.backgroundOpacity;
        
        // Add tap gesture recognizer to background view for hiding alert view.
        if (self.enableTapOutsideToDismiss) {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
            [backgroundView addGestureRecognizer:tapGestureRecognizer];
        }
        
        [_containerView addSubview:backgroundView];
        [self constraintsForFillingInSuperViewOfView:backgroundView];
    }
    
    return _containerView;
}

@end