//
//  SRMModalContainerController.h
//  Example
//
//  Created by S.R on 16/3/27.
//  Copyright © 2016年 S.R. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SRMModalContainerControllerDelegate;

@interface SRMModalContainerController : UIViewController

@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) CGFloat backgroundOpacity;
@property (nonatomic) BOOL shouldRotate;
@property (nonatomic) UIStatusBarStyle statusBarStyle;
@property (nonatomic, weak) id<SRMModalContainerControllerDelegate> delegate;

@end

@protocol SRMModalContainerControllerDelegate <NSObject>

- (void)didTapBackgrounView;

@end
