//
//  DBGuestureLock.h
//  DBGuestureLock
//
//  Created by DeBao.Wu on 2/27/16.
//  Email: i36.lib@gmail.com    QQ: 754753371
//  Copyright © 2016 http://i36.Me/. All rights reserved.
//  Github地址: https://github.com/i36lib/DBGuestureLock/

#import <UIKit/UIKit.h>
#define DBFirstTimeSetupPassword @"Me_i36_DBGuestureLock_DBFirstSetupPswd"

@class DBGuestureLock;

// Button state
typedef NS_ENUM(NSInteger, DBButtonState) {
    DBButtonStateNormal = 0,
    DBButtonStateSelected,
    DBButtonStateIncorrect,
};

// Delegate
@protocol DBGuestureLockDelegate <NSObject>

@required
-(void)guestureLock:(DBGuestureLock *)lock didSetPassword:(NSString*)password;
-(void)guestureLock:(DBGuestureLock *)lock didGetCorrectPswd:(NSString*)password;
-(void)guestureLock:(DBGuestureLock *)lock didGetIncorrectPswd:(NSString*)password;

@optional
-(BOOL)showButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(BOOL)fillButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(CGFloat)widthOfButtonCircleStrokeOnState:(DBButtonState)buttonState;
-(CGFloat)radiusOfButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(CGFloat)lineWidthOfGuestureOnState:(DBButtonState)buttonState;
-(UIColor *)colorOfButtonCircleStrokeOnState:(DBButtonState)buttonState;
-(UIColor *)colorForFillingButtonCircleOnState:(DBButtonState)buttonState;
-(UIColor *)colorOfButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(UIColor *)lineColorOfGuestureOnState:(DBButtonState)buttonState;

@end

// Class
@interface DBGuestureLock : UIView

@property (nonatomic, readonly, assign)BOOL fillCenterPoint;
@property (nonatomic, readonly, assign)BOOL showCenterPoint;
@property (nonatomic, readonly, assign)CGFloat lineWidth;
@property (nonatomic, readonly, assign)CGFloat circleRadius;
@property (nonatomic, readonly, assign)CGFloat strokeWidth;
@property (nonatomic, readonly, assign)CGFloat centerPointRadius;
@property (nonatomic, readonly, strong)UIColor *lineColor;
@property (nonatomic, readonly, strong)UIColor *fillColor;
@property (nonatomic, readonly, strong)UIColor *strokeColor;
@property (nonatomic, readonly, strong)UIColor *centerPointColor;

@property (nonatomic, readonly, assign)BOOL isPasswordSetup;
@property (nonatomic, copy)NSString *firstTimeSetupPassword;
@property (nonatomic, assign)id<DBGuestureLockDelegate> delegate;
@property (nonatomic, copy) void(^onPasswordSet)(DBGuestureLock *lock, NSString *password);
@property (nonatomic, copy) void(^onGetCorrectPswd)(DBGuestureLock *lock, NSString *password);
@property (nonatomic, copy) void(^onGetIncorrectPswd)(DBGuestureLock *lock, NSString *password);

// Password
+(BOOL)passwordSetupStatus;
+(void)clearGuestureLockPassword;
+(NSString *)getGuestureLockPassword;

//Working with protocal
+(instancetype)lockOnView:(UIView*)view delegate:(id<DBGuestureLockDelegate>)delegate;

//Working with block
+(instancetype)lockOnView:(UIView*)view onPasswordSet:(void (^)(DBGuestureLock *lock, NSString *password))onPasswordSet onGetCorrectPswd:(void (^)(DBGuestureLock *lock, NSString *password))GetCorrectPswd onGetIncorrectPswd:(void (^)(DBGuestureLock *lock, NSString *password))GetIncorrectPswd;

//Setup lock theme
-(void)setupLockThemeWithLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth  strokeColor:(UIColor*)strokeColor strokeWidth:(CGFloat)strokeWidth circleRadius:(CGFloat)circleRadius fillColor:(UIColor*)fillColor showCenterPoint:(BOOL)showCenterPoint centerPointColor:(UIColor*)centerPointColor centerPointRadius:(CGFloat)centerPointRadius fillCenterPoint:(BOOL)fillCenterPoint onState:(DBButtonState)buttonState;

@end
