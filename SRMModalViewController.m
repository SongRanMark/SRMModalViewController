//
//  SRMModalViewController.m
//  Example
//
//  Created by marksong on 3/25/16.
//  Copyright © 2016 S.R. All rights reserved.
//

#import "SRMModalViewController.h"
#import "SRMModalContainerController.h"
#import "UIView+Constraint.h"

@interface SRMModalViewController () <SRMModalContainerControllerDelegate>

@property (nonatomic) SRMModalContainerController *containerViewController;
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
    self.containerViewController.backgroundColor = self.backgroundColor;
    self.containerViewController.backgroundOpacity = self.backgroundOpacity;
    UIView *containerView = self.containerViewController.view;
    [keyWindow addSubview:containerView];
    [containerView addConstraintsForFillingInSuperView];
    [containerView addSubview:view];
    [view addConstraintsForCenterInSuperView];
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

#pragma mark SRMModalContainerControllerDelegate

- (void)didTapBackgrounView {
    if (!self.enableTapOutsideToDismiss) {
        return;
    }
    
    [self hide];
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
    [self.contentView removeFromSuperview];
    [self.containerViewController.view removeFromSuperview];
    self.contentView = nil;
    self.contentViewController = nil;
    
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
        self.containerViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self clear];
    }];
}

#pragma mark Getter

- (UIViewController *)containerViewController {
    if (!_containerViewController) {
        _containerViewController = [SRMModalContainerController new];
        _containerViewController.delegate = self;
    }
    
    return _containerViewController;
}

@end