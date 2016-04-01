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

NSString *const SRMModalViewWillShowNotification = @"SRMModalViewWillShowNotification";
NSString *const SRMModalViewDidShowNotification = @"SRMModalViewDidShowNotification";
NSString *const SRMModalViewWillHideNotification = @"SRMModalViewWillHideNotification";
NSString *const SRMModalViewDidHideNotification = @"SRMModalViewDidHideNotification";

@interface SRMModalViewController () <SRMModalContainerControllerDelegate>

@property (nonatomic) UIWindow *window;
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
    [self postWillShowNotification];
    self.containerViewController.backgroundColor = self.backgroundColor;
    self.containerViewController.backgroundOpacity = self.backgroundOpacity;
    self.containerViewController.shouldRotate = self.shouldRotate;
    self.containerViewController.statusBarStyle = self.statusBarStyle;
    [self.containerViewController.view addSubview:view];
    [view addConstraintsForCenterInSuperView];
    self.contentView = view;
    self.window.rootViewController = self.containerViewController;
    [self.window makeKeyAndVisible];
    
    // Keep reference of self.
    if ([self shouldRetainSelf]) {
        [[[self class] instanceArray] addObject:self];
    }
    
    switch (self.showingAnimationStyle) {
        case SRMShowingAnimationStyleDefault:
            [self showingWithAnimationStyleDefault];
            break;
        default:
            [self postDidShowNotification];
            break;
    }
}

- (void)hide {
    [self postWillHideNotification];
    
    switch (self.hidingAnimationStyle) {
        case SRMHidingAnimationStyleDefault:
            [self hidingWithAnimationStyleDefault];
            break;
        default:
            [self clear];
            [self postDidHideNotification];
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
    self.contentView = nil;
    self.contentViewController = nil;
    self.window.rootViewController = nil;
    self.window.hidden = YES;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    
    // Remove reference of self.
    if ([self shouldRetainSelf]) {
        [[[self class] instanceArray] removeObject:self];
    }
}

- (void)showingWithAnimationStyleDefault {
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    } completion:^(BOOL finished) {
        [self postDidShowNotification];
    }];
}

- (void)hidingWithAnimationStyleDefault {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self clear];
        [self postDidHideNotification];
        self.containerViewController.view.alpha = 1;
    }];
}

- (void)postWillShowNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:SRMModalViewWillShowNotification object:nil];
    
    if ([self.delegate respondsToSelector:@selector(modalViewWillShow:)]) {
        [self.delegate modalViewWillShow:self];
    }
}

- (void)postDidShowNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:SRMModalViewDidShowNotification object:nil];
    
    if ([self.delegate respondsToSelector:@selector(modalViewDidShow:)]) {
        [self.delegate modalViewDidShow:self];
    }
}

- (void)postWillHideNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:SRMModalViewWillHideNotification object:nil];
    
    if ([self.delegate respondsToSelector:@selector(modalViewWillHide:)]) {
        [self.delegate modalViewWillHide:self];
    }
}

- (void)postDidHideNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:SRMModalViewDidHideNotification object:nil];
    
    if ([self.delegate respondsToSelector:@selector(modalViewDidHide:)]) {
        [self.delegate modalViewDidHide:self];
    }
}

#pragma mark Getter

- (UIViewController *)containerViewController {
    if (!_containerViewController) {
        _containerViewController = [SRMModalContainerController new];
        _containerViewController.delegate = self;
    }
    
    return _containerViewController;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.windowLevel = UIWindowLevelAlert;
        _window.opaque = NO;
    }
    
    return _window;
}

@end