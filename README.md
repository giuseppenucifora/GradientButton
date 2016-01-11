# GradientButton

[![CI Status](http://img.shields.io/travis/Giuseppe Nucifora/GradientButton.svg?style=flat)](https://travis-ci.org/Giuseppe Nucifora/GradientButton)
[![Version](https://img.shields.io/cocoapods/v/GradientButton.svg?style=flat)](http://cocoapods.org/pods/GradientButton)
[![License](https://img.shields.io/cocoapods/l/GradientButton.svg?style=flat)](http://cocoapods.org/pods/GradientButton)
[![Platform](https://img.shields.io/cocoapods/p/GradientButton.svg?style=flat)](http://cocoapods.org/pods/GradientButton)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GradientButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GradientButton"
```

```ruby

GradientButton *button = [[GradientButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
[button setCenter:self.view.center];
[button setTitle:@"Normal Button" forState:UIControlStateNormal];
[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
[button setbackgroundLayerWithColors:@[[UIColor redColor],[UIColor blueColor]] startPoint:CGPointMake(0, 0)];

[self.view addSubview:button];

GradientButton *autoLayoutButton = [GradientButton newAutoLayoutView];

[autoLayoutButton setTitle:@"Autolayout Button" forState:UIControlStateNormal];
[autoLayoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
[autoLayoutButton setbackgroundLayerWithColors:@[[UIColor redColor],[UIColor greenColor],[UIColor whiteColor]] startPoint:CGPointMake(0, 0)];

[self.view addSubview:autoLayoutButton];

````

## Author

Giuseppe Nucifora, me@giuseppenucifora.com

## License

GradientButton is available under the MIT license. See the LICENSE file for more info.
