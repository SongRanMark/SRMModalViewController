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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)changeBackgroundOpacity:(UISlider *)sender {
    [SRMModalViewController sharedInstance].backgroundOpacity = sender.value;
}

- (IBAction)changeBackgroundColor:(UISegmentedControl *)sender {
    UIColor *backgroundColor;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            backgroundColor = [UIColor blackColor];
            break;
        case 1:
            backgroundColor = [UIColor redColor];
            break;
        case 2:
            backgroundColor = [UIColor greenColor];
            break;
        case 3:
            backgroundColor = [UIColor blueColor];
            break;
    }
    
    [SRMModalViewController sharedInstance].backgroundColor = backgroundColor;
}

- (IBAction)showModalView:(id)sender {
    [SRMModalViewController sharedInstance].delegate = self;
    [SRMModalViewController sharedInstance].enableTapOutsideToDismiss = NO;
//    [SRMModalViewController sharedInstance].shouldRotate = NO;
    [SRMModalViewController sharedInstance].statusBarStyle = UIStatusBarStyleLightContent;
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    viewController.view.frame = CGRectMake(0, 0, 200, 200);
    [[SRMModalViewController sharedInstance] showViewWithController:viewController];
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
