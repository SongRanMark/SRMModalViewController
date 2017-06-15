# SRMModalViewController

[![Version](https://img.shields.io/cocoapods/v/SRMModalViewController.svg?style=flat)](http://cocoapods.org/pods/SRMModalViewController)
[![Platform](https://img.shields.io/cocoapods/p/SRMModalViewController.svg?style=flat)](http://cocoapods.org/pods/SRMModalViewController)
[![License](https://img.shields.io/cocoapods/l/SRMModalViewController.svg?style=flat)](http://cocoapods.org/pods/SRMModalViewController)

SRMModalViewController support a easy way to display a view with modal style.

## Installation

SRMModalViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SRMModalViewController"
```

## Usage

```objective-c
UIViewController *viewController = [UIViewController new];
viewController.view.frame = CGRectMake(0, 0, 200, 200);
viewController.view.backgroundColor = [UIColor whiteColor];
[[SRMModalViewController sharedInstance] showViewWithController:viewController];
```

or

```objective-c
UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
view.backgroundColor = [UIColor whiteColor];
[[SRMModalViewController sharedInstance] showView:view];
```

#### Custom color and opacity of background mask.

```objective-c
[SRMModalViewController sharedInstance].backgroundColor = [UIColor blackColor];
```

![](https://github.com/SongRanMark/SRMModalViewController/blob/master/README%20resource/BackgroundColor.gif)

```objective-c
[SRMModalViewController sharedInstance].backgroundOpacity = 0.5;
```

![](https://github.com/SongRanMark/SRMModalViewController/blob/master/README%20resource/BackgroundOpacity.gif)

#### Show another one in a modal view diplayed already.

```objective-c
// Hide first one
[[SRMModalViewController sharedInstance] showView:self.contentView];
// Do not hide first one
SRMModalViewController *modalViewController = [SRMModalViewController new];
[modalViewController showView:self.contentView];
```

![](https://github.com/SongRanMark/SRMModalViewController/blob/master/README%20resource/ShowAnother.gif)

You can download example project to get more info.

## Author

S.R, firecrackerinlane2@gmail.com

## License

SRMModalViewController is available under the MIT license. See the LICENSE file for more info.
