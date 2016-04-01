# SRMModalViewController

[![Version](https://img.shields.io/cocoapods/v/SRMModalViewController.svg?style=flat)](http://cocoapods.org/pods/SRMModalViewController)
[![Platform](https://img.shields.io/cocoapods/p/SRMModalViewController.svg?style=flat)](http://cocoapods.org/pods/SRMModalViewController)
[![License](https://img.shields.io/cocoapods/l/SRMModalViewController.svg?style=flat)](http://cocoapods.org/pods/SRMModalViewController)

## Installation

SRMModalViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SRMModalViewController"
```

## Usage

```objective-c
SRMModalViewController *modalViewController = [SRMModalViewController new];
UIViewController *viewController = [UIViewController new];
viewController.view.frame = CGRectMake(0, 0, 200, 200);
viewController.view.backgroundColor = [UIColor whiteColor];
[modalViewController showViewWithController:viewController];
```

or

```objective-c
UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
view.backgroundColor = [UIColor whiteColor];
[modalViewController showView:view];
```

You can custom color and opacity of background mask.

```objective-c
modalViewController.backgroundColor = [UIColor blackColor];
```

<img src="README resource/BackgroundColor.gif" style="width:270px;height:480px">

```objective-c
modalViewController.backgroundOpacity = 0.5;
```

<img src="README resource/BackgroundOpacity.gif" style="width:270px;height:480px">

You can download example project to get more info.

## Author

S.R, firecrackerinlane2@gmail.com

## License

SRMModalViewController is available under the MIT license. See the LICENSE file for more info.
