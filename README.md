# DBGuestureLock [English](https://github.com/i36lib/DBGuestureLock/blob/master/READMEEN.md)
[![Build Status](https://travis-ci.org/i36lib/DBGuestureLock.svg)](https://travis-ci.org/i36lib/DBGuestureLock)   [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://opensource.org/licenses/MIT)

`DBGuestureLock`是一个简单易用，方便上手，可配置的 iOS 手势密码组件。如果您愿意，非常欢迎您为这个项目增加其他有用的功能，如果您需要为这个项目做一份贡献，只需要提交一个`pull request`到这个项目即可。如果您喜欢这个组件并觉得它不错，欢迎您给它加个星。

[![](http://i36.me/images/devref/DBGuestureLock_TEST.png)](http://i36.me/images/devref/DBGuestureLock_TEST.png)

## 前置条件

`DBGuestureLock`是在iOS `SDK9.2`和`Xcode7.2.1(7C1002)`下构建的，在[Travis-ci](https://travis-ci.org/)上使用`Xcode7`和iOS `SDK9.0`来测试并通过。 该组件基于`ARC`，需要支持的框架为：

* UIKit.framework

## 在项目中DBGuestureLock

### 源文件

直接拷贝`DBGuestureButton.h`, `DBGuestureButton.m`,`DBGuestureLock.h`, `DBGuestureLock.m`四个源文件到项目中即可，请勾选必要时Copy文件选项。

1. 下载[最新版本代码](https://github.com/i36lib/DBGuestureLock/archive/master.zip)或者直接使用Git克隆这个项目到你本地来获取最新代码。
2. 打开你的Xcode, 然后拖拽这四个源文件到你的工程项目中(使用"Product Navigator view")，如果源文件不在你的项目文件夹内，请在拖拽时确保勾选“Copy”选项。
3. 在你想添加到的视图的ViewController中使用命令`#import "DBGuestureLock.h"`来引入头文件，这样就可以使用了。

## 使用方法

在你想添加到的视图的ViewController中导入`DBGuestureLock.h`头文件，然后让这个视图控制器实现`DBGuestureLockDelegate`委托，或者你可以在别的类当中实现该委托，在新建Lock时指定即可：
```objective-c
#import "DBGuestureLock.h"

@interface ViewController ()<DBGuestureLockDelegate>
```

在`viewDidLoad`方法中创建一个`GuestureLock`对象，然后添加到视图:
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    [DBGuestureLock clearGuestureLockPassword]; //just for test
    
    DBGuestureLock *lock = [DBGuestureLock lockOnView:self.view delegate:self];
    [self.view addSubview:lock];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.133 green:0.596 blue:0.933 alpha:1.00]];
}
```

实现三个必须实现的委托方法，这三个方法在密码被设置时，密码输入正确和错误时被调用，下面给出的样例代码提供了一种设置密码和验证的方式，详细可参考代码Demo：
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

另外提供了一些委托方法用来更改按钮的颜色和线条粗细，可自行根据需要使用:
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

另外提供了一些类方法和属性来对密码进行操作，密码是存储在`UserDefaults`当中的：
```objective-c
+(BOOL)passwordSetupStatus;
+(void)clearGuestureLockPassword;
+(NSString *)getGuestureLockPassword;
@property (nonatomic, readonly, assign)BOOL isPasswordSetup;
```

## 代码使用协议

本项目代码遵从`MIT`协议，协议内容参见[MIT license](LICENSE)文件。
