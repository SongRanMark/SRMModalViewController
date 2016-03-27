//
//  ViewController.m
//  Example
//
//  Created by marksong on 3/25/16.
//  Copyright © 2016 S.R. All rights reserved.
//

#import "ViewController.h"
#import "SRMModalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showModalView:(id)sender {
    SRMModalViewController *modalViewController = [SRMModalViewController new];
//    modalViewController.enableTapOutsideToDismiss = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [modalViewController showView:view];
}

@end
