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

@property (nonatomic) UIWindow *window;
@property (nonatomic) SRMModalViewController *modalVC;

@end

@implementation ViewController

- (void)viewDidLoad {
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewWillShowNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewDidShowNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewWillHideNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewDidHideNotification object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (SRMModalViewController *)modalVC {
    if (!_modalVC) {
        _modalVC = [SRMModalViewController new];
    }
    
    return _modalVC;
}

- (IBAction)changeBackgroundOpacity:(UISlider *)sender {
    self.modalVC.backgroundOpacity = sender.value;
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
    
    self.modalVC.backgroundColor = backgroundColor;
}

- (IBAction)showModalView:(id)sender {
//    self.modalVC.delegate = self;
//    self.modalVC.enableTapOutsideToDismiss = NO;
//    self.modalVC.shouldRotate = NO;
    self.modalVC.statusBarStyle = UIStatusBarStyleLightContent;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.modalVC showView:view];
    UIViewController *viewController = [UIViewController new];
    viewController.view.frame = CGRectMake(0, 0, 200, 200);
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.modalVC showViewWithController:viewController];
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
