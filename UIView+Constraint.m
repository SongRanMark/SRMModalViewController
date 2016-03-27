//
//  UIView+Constraint.m
//  Example
//
//  Created by S.R on 16/3/27.
//  Copyright © 2016年 S.R. All rights reserved.
//

#import "UIView+Constraint.h"

@implementation UIView (Constraint)

- (void)addConstraintsForFillingInSuperView {
    // Content view should be added to super view firstly.
    if (!self.superview) {
        return;
    }
    
    static NSString *viewKey = @"view";
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *horizontalConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|", viewKey] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{viewKey:self}];
    NSArray *verticalConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", viewKey] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{viewKey:self}];
    NSMutableArray *constraintArray = [NSMutableArray new];
    [constraintArray addObjectsFromArray:horizontalConstraintArray];
    [constraintArray addObjectsFromArray:verticalConstraintArray];
    [self.superview addConstraints:constraintArray];
}

- (void)addConstraintsForCenterInSuperView {
    // Content view should be added to super view firstly.
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetWidth(self.frame)];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetHeight(self.frame)];
    NSLayoutConstraint *horizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *verticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSArray *constraintArray = @[horizontalCenterConstraint, verticalCenterConstraint, widthConstraint, heightConstraint];
    [self.superview addConstraints:constraintArray];
}

@end
