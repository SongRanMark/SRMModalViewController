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
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewDidShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewWillHideNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(disposeModalViewControllerNotification:) name:SRMModalViewDidHideNotification object:nil];
}

- (SRMModalViewController *)modalVC {
    if (!_modalVC) {
        _modalVC = [SRMModalViewController new];
    }
    
    return _modalVC;
}

- (IBAction)hideKeyboard:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (IBAction)showModalView:(id)sender {
    self.modalVC.backgroundOpacity = 0.5;
    self.modalVC.delegate = self;
//    self.modalVC.enableTapOutsideToDismiss = NO;
//    self.modalVC.shouldRotate = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.modalVC showView:view];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text = @"do rotate?";
    [view addSubview:label];
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
