//
//  SRMModalViewController.h
//  Example
//
//  Created by marksong on 3/25/16.
//  Copyright © 2016 S.R. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol SRMModalViewControllerDelegate;

typedef NS_ENUM(NSUInteger, SRMShowingAnimationStyle) {
    SRMShowingAnimationStyleNone,
    SRMShowingAnimationStyleDefault
};

typedef NS_ENUM(NSUInteger, SRMHidingAnimationStyle) {
    SRMHidingAnimationStyleNone,
    SRMHidingAnimationStyleDefault
};

extern NSString *const SRMModalViewWillShowNotification;
extern NSString *const SRMModalViewDidShowNotification;
extern NSString *const SRMModalViewWillHideNotification;
extern NSString *const SRMModalViewDidHideNotification;

@interface SRMModalViewController : NSObject

@property (nonatomic, weak) id<SRMModalViewControllerDelegate> delegate;
// The color of the background mask view, default value is black.
@property (nonatomic) UIColor *backgroundColor;
// The opacity of the background mask view, default value is 0.4.
@property (nonatomic) CGFloat backgroundOpacity;
// Determines whether the modal should dismiss when the user taps outside of the modal view, default value is YES.
@property (nonatomic) BOOL enableTapOutsideToDismiss;
// Determines whether the modal should rotate when the device do it, default value is YES.
@property (nonatomic) BOOL shouldRotate;
@property (nonatomic) SRMShowingAnimationStyle showingAnimationStyle;
@property (nonatomic) SRMHidingAnimationStyle hidingAnimationStyle;

- (void)showView:(UIView *)view;
- (void)showViewWithController:(UIViewController *)viewController;
- (void)hide;

@end

@protocol SRMModalViewControllerDelegate <NSObject>

- (void)modalViewWillShow:(SRMModalViewController *)modalViewController;
- (void)modalViewDidShow:(SRMModalViewController *)modalViewController;
- (void)modalViewWillHide:(SRMModalViewController *)modalViewController;
- (void)modalViewDidHide:(SRMModalViewController *)modalViewController;

@end