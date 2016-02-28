# DBGuestureLock [中文](https://github.com/i36lib/DBGuestureLock/blob/master/READMECN.md)
[![Build Status](https://travis-ci.org/i36lib/DBGuestureLock.svg)](https://travis-ci.org/i36lib/DBGuestureLock)  [![Cocoapods compatible](https://img.shields.io/badge/pod-v0.0.1-blue.svg?style=flat)](https://cocoapods.org/pods/DBGuestureLock)  [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://opensource.org/licenses/MIT)

`DBGuestureLock` is an iOS drop-in class which is very easy to use. I am welcome you to make any additional useful features to DBGuestureLock to make it better. If you want to make a contribution to this project, just make a pull request. If you like this project, make a star!

[![](http://i36.me/images/devref/DBGuestureLock_TEST.png)](http://i36.me/images/devref/DBGuestureLock_TEST.png)

## NO.1 Requirements

`DBGuestureLock` is build under iOS `SDK9.2` with `Xcode7.2.1(7C1002)` and pass test on travis-ci with `Xcode7` and iOS `SDK9.0`. You should use DBGuestureLock under `ARC`.

* UIKit.framework

## NO.2 Adding DBGuestureLock to your project

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add DBGuestureLock to your project.

1. Add a pod entry for DBGuestureLock to your Podfile `pod 'DBGuestureLock', '~> 0.0.1'`
2. Install the pod(s) by running `pod install`.
3. Include DBGuestureLock wherever you need it with `#import "DBGuestureLock.h"`.

Open your project with Xcode using `your_project_name.xcworkspace` instead.

### Source files

Just add the `DBGuestureButton.h`, `DBGuestureButton.m`,`DBGuestureLock.h`, `DBGuestureLock.m` source files to your project directly.

1. Download the [latest code version](https://github.com/i36lib/DBGuestureLock/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop the 4 source files onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include DBGuestureLock in your ViewController where you want to add the guesture lock with `#import "DBGuestureLock.h"`.

## NO.3 Usage

Import the `DBGuestureLock.h` in your `ViewController` and make your ViewController conforms to `DBGuestureLockDelegate` delegate:
```objective-c
#import "DBGuestureLock.h"

@interface ViewController ()<DBGuestureLockDelegate>
```

Create a `GuestureLock` object and add it to your view in `viewDidLoad` method:
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    [DBGuestureLock clearGuestureLockPassword]; //just for test
    
    DBGuestureLock *lock = [DBGuestureLock lockOnView:self.view delegate:self];
    [self.view addSubview:lock];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.133 green:0.596 blue:0.933 alpha:1.00]];
}
```

Implement the 3 require delegate methods:
```objective-c
-(void)guestureLock:(DBGuestureLock *)lock didSetPassword:(NSString *)password {
    // test
    if (lock.firstTimeSetupPassword == nil) {
        lock.firstTimeSetupPassword = password;
        NSLog(@"varify your password");
        self.label.text = @"Enter your password again:";
    }
}

-(void)guestureLock:(DBGuestureLock *)lock didGetCorrectPswd:(NSString *)password {
    // test
    if (lock.firstTimeSetupPassword && ![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
        lock.firstTimeSetupPassword = DBFirstTimeSetupPassword;
        NSLog(@"password has been setup!");
        self.label.text = @"password has been setup!";
    } else {
        NSLog(@"login success");
        self.label.text = @"login success!";
    }
}

-(void)guestureLock:(DBGuestureLock *)lock didGetIncorrectPswd:(NSString *)password {
    // test
    if (![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
        NSLog(@"Error: password not equal to first setup!");
        self.label.text = @"Not equal to first setup!";
    } else {
        NSLog(@"login failed");
        self.label.text = @"login failed!";
    }
}
```

Some other optional delegate methods allow you to change the style of the lock:
```objective-c
-(BOOL)showButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(BOOL)fillButtonCircleCenterPointOnState:(DBButtonState)buttonState;//NO for stroke, YES for fill
-(CGFloat)widthOfButtonCircleStrokeOnState:(DBButtonState)buttonState;
-(CGFloat)radiusOfButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(CGFloat)lineWidthOfGuestureOnState:(DBButtonState)buttonState;
-(UIColor *)colorOfButtonCircleStrokeOnState:(DBButtonState)buttonState;
-(UIColor *)colorForFillingButtonCircleOnState:(DBButtonState)buttonState;
-(UIColor *)colorOfButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(UIColor *)lineColorOfGuestureOnState:(DBButtonState)buttonState;
```

Other class methods/property allow you to operate the password:
```objective-c
+(BOOL)passwordSetupStatus;
+(void)clearGuestureLockPassword;
+(NSString *)getGuestureLockPassword;
@property (nonatomic, readonly, assign)BOOL isPasswordSetup;
```

## NO.4 License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
