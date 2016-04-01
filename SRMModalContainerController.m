//
//  SRMModalContainerController.m
//  Example
//
//  Created by S.R on 16/3/27.
//  Copyright © 2016年 S.R. All rights reserved.
//

#import "SRMModalContainerController.h"
#import "UIView+Constraint.h"

@interface SRMModalContainerController ()

@property (nonatomic) UIView *backgroundView;

@end

@implementation SRMModalContainerController

#pragma mark Override

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addConstraintsForFillingInSuperView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForTappingBackgroundView)];
    [self.backgroundView addGestureRecognizer:tapGestureRecognizer];
}

- (BOOL)shouldAutorotate {
    return self.shouldRotate;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

#pragma mark Responder

- (void)actionForTappingBackgroundView {
    if ([self.delegate respondsToSelector:@selector(didTapBackgrounView)]) {
        [self.delegate didTapBackgrounView];
    }
}

#pragma mark Setter

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setBackgroundOpacity:(CGFloat)backgroundOpacity {
    _backgroundOpacity = backgroundOpacity;
    
    // UIView cannot handle touch event when alpha less than or equal to 0.01.
    if (backgroundOpacity <= 0.01) {
        backgroundOpacity = 0.02;
    }
    
    self.backgroundView.alpha = backgroundOpacity;
}

#pragma mark Getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
    }
    
    return _backgroundView;
}

@end
