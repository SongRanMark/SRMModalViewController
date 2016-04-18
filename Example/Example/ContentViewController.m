//
//  ContentViewController.m
//  Example
//
//  Created by S.R on 16/4/16.
//  Copyright © 2016年 S.R. All rights reserved.
//

#import "ContentViewController.h"
#import "SRMModalViewController.h"

@interface ContentViewController ()

@property (nonatomic) UIView *contentView;

@end

@implementation ContentViewController

- (IBAction)close:(id)sender {
    [[SRMModalViewController sharedInstance] hide];
}

- (IBAction)hide:(id)sender {
    [SRMModalViewController sharedInstance].enableTapOutsideToDismiss = YES;
    [[SRMModalViewController sharedInstance] showView:self.contentView];
}

- (IBAction)notHide:(id)sender {
    SRMModalViewController *modalViewController = [SRMModalViewController new];
    [modalViewController showView:self.contentView];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _contentView.backgroundColor = [UIColor grayColor];
    }
    
    return _contentView;
}

@end
