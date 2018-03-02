# DBGuestureLock [English](https://github.com/i36lib/DBGuestureLock/blob/master/README.md)
[![Build Status](https://travis-ci.org/i36lib/DBGuestureLock.svg)](https://travis-ci.org/i36lib/DBGuestureLock)  [![Cocoapods compatible](https://img.shields.io/badge/pod-v0.0.2-blue.svg?style=flat)](https://cocoapods.org/pods/DBGuestureLock)  [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://opensource.org/licenses/MIT)

`DBGuestureLock`是一个简单易用，方便上手，可配置的 iOS 手势密码组件。如果您愿意，非常欢迎您为这个项目增加其他有用的功能，如果您需要为这个项目做一份贡献，只需要提交一个`pull request`到这个项目即可。如果您喜欢这个组件并觉得它不错，欢迎您给它加个星。

[![](http://i36.me/images/devref/DBGuestureLock_TEST.png)](http://i36.me/images/devref/DBGuestureLock_TEST.png)

## 一、前置条件

`DBGuestureLock`是在iOS `SDK9.2`和`Xcode7.2.1(7C1002)`下构建的，在[Travis-ci](https://travis-ci.org/)上使用`Xcode7`和iOS `SDK9.0`来测试并通过。 该组件基于`ARC`，需要支持的框架为：

* UIKit.framework

## 二、在项目中使用DBGuestureLock

### Cocoapods

推荐使用[CocoaPods](http://cocoapods.org)来将`DBGuestureLock`添加到你的项目当中：

1. 在你的Podfile当中为DBGuestureLock增加一个安装入口： `pod 'DBGuestureLock', '~> 0.0.2'`
2. 然后执行命令来安装Pod组件： `pod install`.
3. 在你的项目代码当中引入DBGuestureLock来进行使用 `#import "DBGuestureLock.h"`.

之后使用`your_project_name.xcworkspace`来打开和使用你的项目。

### 源文件方式

直接拷贝`DBGuestureButton.h`, `DBGuestureButton.m`,`DBGuestureLock.h`, `DBGuestureLock.m`四个源文件到项目中即可，请勾选必要时Copy文件选项。

1. 下载[最新版本代码](https://github.com/i36lib/DBGuestureLock/archive/master.zip)或者直接使用Git克隆这个项目到你本地来获取最新代码。
2. 打开你的Xcode, 然后拖拽这四个源文件到你的工程项目中(使用"Product Navigator view")，如果源文件不在你的项目文件夹内，请在拖拽时确保勾选“Copy”选项。
3. 在你想添加到的视图的ViewController中使用命令`#import "DBGuestureLock.h"`来引入头文件，这样就可以使用了。

## 三、使用方法

提供了两种方式来使用DBGuestureLock，一种是实现委托（delegate），一种是使用block。

### 使用Block的方式

这种方式比使用委托的方式更简便，两句代码搞定。在你想添加到的视图的ViewController中导入`DBGuestureLock.h`头文件：
```objective-c
#import "DBGuestureLock.h"
```

在`viewDidLoad`方法中创建一个`GuestureLock`对象，然后添加到视图:
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    [DBGuestureLock clearGuestureLockPassword]; //just for test
    
	DBGuestureLock *lock = [DBGuestureLock lockOnView:self.view offsetFromBottom:60.f onPasswordSet:^(DBGuestureLock *lock, NSString *password) {
        if (lock.firstTimeSetupPassword == nil) {
            lock.firstTimeSetupPassword = password;
            NSLog(@"varify your password");
            self.label.text = @"Enter your password again:";
        }
    } onGetCorrectPswd:^(DBGuestureLock *lock, NSString *password) {
        if (lock.firstTimeSetupPassword && ![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
            lock.firstTimeSetupPassword = DBFirstTimeSetupPassword;
            NSLog(@"password has been setup!");
            self.label.text = @"password has been setup!";
        } else {
            NSLog(@"login success");
            self.label.text = @"login success!";
        }
    } onGetIncorrectPswd:^(DBGuestureLock *lock, NSString *password) {
        if (![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
            NSLog(@"Error: password not equal to first setup!");
            self.label.text = @"Not equal to first setup!";
        } else {
            NSLog(@"login failed");
            self.label.text = @"login failed!";
        }
    }];
    [self.view addSubview:lock];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.133 green:0.596 blue:0.933 alpha:1.00]];
}
```

如果需要更改按钮的颜色和线条粗细，可针对DBButtonState的三种状态分别调用如下方法进行设置即可：
```objective-c
-(void)setupLockThemeWithLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth  strokeColor:(UIColor*)strokeColor strokeWidth:(CGFloat)strokeWidth circleRadius:(CGFloat)circleRadius fillColor:(UIColor*)fillColor showCenterPoint:(BOOL)showCenterPoint centerPointColor:(UIColor*)centerPointColor centerPointRadius:(CGFloat)centerPointRadius fillCenterPoint:(BOOL)fillCenterPoint onState:(DBButtonState)buttonState;
```

### 使用委托的方式

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
    
    DBGuestureLock *lock = [DBGuestureLock lockOnView:self.view offsetFromBottom:60.f delegate:self];
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

### 其他方法和属性

`DBButtonState` 包括三种状态:
```objective-c
DBButtonStateNormal     //正常状态下的按钮样式
DBButtonStateSelected   //当按钮被选中时的样式
DBButtonStateIncorrect  //当密码输入错误时选中按钮的样式
```

另外提供了一些类方法和属性来对密码进行操作，密码是存储在`UserDefaults`当中的：
```objective-c
+(BOOL)passwordSetupStatus;
+(void)clearGuestureLockPassword;
+(NSString *)getGuestureLockPassword;
@property (nonatomic, readonly, assign)BOOL isPasswordSetup;
```

## 四、代码使用协议

本项目代码遵从`MIT`协议，协议内容参见[MIT license](LICENSE)文件。


## 五、版本日志一览

1. **2016/02/28:** V0.0.1	第一次提交，支持CocoaPods，完善使用文档，使用delegate的方式调用
1. **2016/02/29:** V0.0.2	在delegate的基础上增加block方式使用，可在block和delegate两种方式中选择
