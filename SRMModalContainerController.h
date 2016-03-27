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

// The color of the background mask view, default value is black.
@property (nonatomic) UIColor *backgroundColor;
// The opacity of the background mask view, default value is 0.4.
@property (nonatomic) CGFloat backgroundOpacity;
@property (nonatomic, weak) id<SRMModalContainerControllerDelegate> delegate;

@end

@protocol SRMModalContainerControllerDelegate <NSObject>

- (void)didTapBackgrounView;

@end
