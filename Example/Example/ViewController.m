//
//  ViewController.m
//  Example
//
//  Created by marksong on 3/25/16.
//  Copyright © 2016 S.R. All rights reserved.
//

#import "ViewController.h"
#import "SRMModalViewController.h"

@interface ViewController () <SRMModalViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewDidShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewWillHideNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewDidHideNotification object:nil];
}

- (IBAction)showModalView:(id)sender {
    SRMModalViewController *modalViewController = [SRMModalViewController new];
    modalViewController.delegate = self;
//    modalViewController.enableTapOutsideToDismiss = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [modalViewController showView:view];
}

- (void)modalViewWillShow:(SRMModalViewController *)modalViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)modalViewDidShow:(SRMModalViewController *)modalViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)modalViewWillHide:(SRMModalViewController *)modalViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)modalViewDidHide:(SRMModalViewController *)modalViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)disposeModalViewControllerNotification:(NSNotification *)notification {
    NSLog(@"%@", notification.name);
}

@end
