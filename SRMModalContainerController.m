//
//  SRMModalContainerController.m
//  Example
//
//  Created by S.R on 16/3/27.
//  Copyright © 2016年 S.R. All rights reserved.
//

#import "SRMModalContainerController.h"
#import "UIView+Constraint.h"

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

#pragma mark Getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
    }
    
    return _backgroundView;
}

@end
