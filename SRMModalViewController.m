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

+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self class] new];
    });
    
    return sharedInstance;
}

- (void)showViewWithController:(UIViewController *)viewController {
    [self showViewWithController:viewController size:viewController.view.frame.size];
}

- (void)showViewWithController:(UIViewController *)viewController size:(CGSize)size {
    self.contentViewController = viewController;
    viewController.view.frame = CGRectMake(0, 0, size.width, size.height);
    [self showView:viewController.view size:size];
}

- (void)showView:(UIView *)view size:(CGSize)size {
    view.frame = CGRectMake(0, 0, size.width, size.height);
    [self showView:view];
}

- (void)showView:(UIView *)view {
    if (self.contentView) {
        [self hidingWithAnimationStyleDefaultAndCompletion:^{
            [self justShowView:view];
        }];
        
        return;
    }
    
    [self justShowView:view];
}

- (void)justShowView:(UIView *)view {
    self.containerViewController.backgroundView.backgroundColor = self.backgroundColor;
    [self setContainerBackgroundOpacity:self.backgroundOpacity];
    self.containerViewController.backgroundView.alpha = self.backgroundOpacity;
    self.containerViewController.shouldRotate = self.shouldRotate;
    self.containerViewController.statusBarStyle = self.statusBarStyle;
    [self.containerViewController.view addSubview:view];
    [view addConstraintsForCenterInSuperView];
    self.contentView = view;
    [self addReferenceToSelf];
    self.window.rootViewController = self.containerViewController;
    [self postWillShowNotification];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.window makeKeyAndVisible];
        
        switch (self.showingAnimationStyle) {
            case SRMShowingAnimationStyleDefault:
                [self showingWithAnimationStyleDefault];
                break;
            default:
                [self postDidShowNotification];
                break;
        }
    });
}

- (void)hide {
    [self hideWithCompletion:nil];
}

- (void)hideWithCompletion:(void(^)())completion {
    [self postWillHideNotification];
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (self.hidingAnimationStyle) {
            case SRMHidingAnimationStyleDefault:
                [self hidingWithAnimationStyleDefaultAndCompletion:completion];
                break;
            default:
                [self hidingWithAnimationStyleNoneAndCompletion:completion];
                break;
        }
    });
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

// In case that self is a local instance of user.
- (void)addReferenceToSelf {
    [[[self class] instanceArray] addObject:self];
}

- (void)deleteReferenceFromSelf {
    [[[self class] instanceArray] removeObject:self];
}

- (void)clear {
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    self.contentViewController = nil;
    self.window.rootViewController = nil;
    self.window.hidden = YES;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    [self deleteReferenceFromSelf];
}

- (void)showingWithAnimationStyleDefault {
    self.containerViewController.backgroundView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self setContainerBackgroundOpacity:self.backgroundOpacity];
    }];
    self.contentView.alpha = 0;
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.alpha = 1;
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finalFinished) {
            [self postDidShowNotification];
        }];
    }];
}

- (void)hidingWithAnimationStyleDefaultAndCompletion:(void(^)())completion {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerViewController.backgroundView.alpha = 0;
    }];
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentView.alpha = 0;
            self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        } completion:^(BOOL finalFinished){
            self.contentView.alpha = 1;
            self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            [self clear];
            if (completion) completion();
            [self postDidHideNotification];
        }];
    }];
}

- (void)hidingWithAnimationStyleNoneAndCompletion:(void(^)())completion {
        [self clear];
        if (completion) completion();
        [self postDidHideNotification];
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

- (void)setContainerBackgroundOpacity:(CGFloat)backgroundOpacity {
    // UIView cannot handle touch event when alpha less than or equal to 0.01.
    if (backgroundOpacity <= 0.01) {
        backgroundOpacity = 0.02;
    }
    
    self.containerViewController.backgroundView.alpha = backgroundOpacity;
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