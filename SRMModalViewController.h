//
//  SRMModalViewController.h
//  Example
//
//  Created by marksong on 3/25/16.
//  Copyright © 2016 S.R. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SRMShowingAnimationStyle) {
    SRMShowingAnimationStyleNone,
    SRMShowingAnimationStyleDefault
};

typedef NS_ENUM(NSUInteger, SRMHidingAnimationStyle) {
    SRMHidingAnimationStyleNone,
    SRMHidingAnimationStyleDefault
};

@interface SRMModalViewController : NSObject

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
