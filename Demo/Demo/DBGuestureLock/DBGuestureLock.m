//
//  DBGuestureLockView.m
//  DBGuestureLock
//
//  Created by DeBao.Wu on 2/27/16.
//  Email: i36.lib@gmail.com    QQ: 754753371
//  Copyright © 2016 http://i36.Me/. All rights reserved.
//  Github地址: https://github.com/i36lib/DBGuestureLock/

#import "DBGuestureLock.h"
#import "DBGuestureButton.h"
#define DBGuestureLockPaswd @"Me_i36_DBGuestureLock_Password"

@interface DBGuestureLock()

@property (nonatomic, assign)CGPoint currentPoint;
@property (nonatomic, strong)NSMutableArray *selectedButtons;
@property (nonatomic, assign)BOOL isPasswordSetup;

@property (nonatomic, assign)BOOL fillCenterPoint;
@property (nonatomic, assign)BOOL showCenterPoint;
@property (nonatomic, assign)CGFloat lineWidth;
@property (nonatomic, assign)CGFloat circleRadius;
@property (nonatomic, assign)CGFloat strokeWidth;
@property (nonatomic, assign)CGFloat centerPointRadius;
@property (nonatomic, strong)UIColor *lineColor;
@property (nonatomic, strong)UIColor *fillColor;
@property (nonatomic, strong)UIColor *strokeColor;
@property (nonatomic, strong)UIColor *centerPointColor;

//Work with block
@property (nonatomic, assign)BOOL fillCenterPointOnStateNormal;
@property (nonatomic, assign)BOOL showCenterPointOnStateNormal;
@property (nonatomic, assign)CGFloat lineWidthOnStateNormal;
@property (nonatomic, assign)CGFloat circleRadiusOnStateNormal;
@property (nonatomic, assign)CGFloat strokeWidthOnStateNormal;
@property (nonatomic, assign)CGFloat centerPointRadiusOnStateNormal;
@property (nonatomic, strong)UIColor *lineColorOnStateNormal;
@property (nonatomic, strong)UIColor *fillColorOnStateNormal;
@property (nonatomic, strong)UIColor *strokeColorOnStateNormal;
@property (nonatomic, strong)UIColor *centerPointColorOnStateNormal;
@property (nonatomic, assign)BOOL fillCenterPointOnStateSelected;
@property (nonatomic, assign)BOOL showCenterPointOnStateSelected;
@property (nonatomic, assign)CGFloat lineWidthOnStateSelected;
@property (nonatomic, assign)CGFloat circleRadiusOnStateSelected;
@property (nonatomic, assign)CGFloat strokeWidthOnStateSelected;
@property (nonatomic, assign)CGFloat centerPointRadiusOnStateSelected;
@property (nonatomic, strong)UIColor *lineColorOnStateSelected;
@property (nonatomic, strong)UIColor *fillColorOnStateSelected;
@property (nonatomic, strong)UIColor *strokeColorOnStateSelected;
@property (nonatomic, strong)UIColor *centerPointColorOnStateSelected;
@property (nonatomic, assign)BOOL fillCenterPointOnStateIncorrect;
@property (nonatomic, assign)BOOL showCenterPointOnStateIncorrect;
@property (nonatomic, assign)CGFloat lineWidthOnStateIncorrect;
@property (nonatomic, assign)CGFloat circleRadiusOnStateIncorrect;
@property (nonatomic, assign)CGFloat strokeWidthOnStateIncorrect;
@property (nonatomic, assign)CGFloat centerPointRadiusOnStateIncorrect;
@property (nonatomic, strong)UIColor *lineColorOnStateIncorrect;
@property (nonatomic, strong)UIColor *fillColorOnStateIncorrect;
@property (nonatomic, strong)UIColor *strokeColorOnStateIncorrect;
@property (nonatomic, strong)UIColor *centerPointColorOnStateIncorrect;

@end

@implementation DBGuestureLock

+(BOOL)passwordSetupStatus {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *password = [defaults valueForKey:DBGuestureLockPaswd];
    if (password == nil || [password length] <= 0) {
        return NO;
    }
    
    return YES;
}

+(void)clearGuestureLockPassword {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue: nil forKey:DBGuestureLockPaswd];
}

+(NSString *)getGuestureLockPassword {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *password = [defaults valueForKey:DBGuestureLockPaswd];
    
    return password;
}

-(BOOL)isPasswordSetup {
    return [[self class] passwordSetupStatus];
}

//@Override
-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if ([self.selectedButtons count]== 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth: self.lineWidth];
    [self.lineColor set];
    [path setLineJoinStyle: kCGLineJoinRound];
    [path setLineCapStyle: kCGLineCapRound];
    
    for (NSInteger i=0; i<[self.selectedButtons count]; i++) {
        DBGuestureButton *button = self.selectedButtons[i];
        if (i == 0) {
            [path moveToPoint:[button center]];
        } else {
            [path addLineToPoint: [button center]];
        }
        [button setNeedsDisplay];
    }
    [path addLineToPoint:self.currentPoint];
    [path stroke];
}

+(instancetype)lockOnView:(UIView*)view delegate:(id<DBGuestureLockDelegate>)delegate {
    CGFloat width = view.frame.size.height > view.frame.size.width ? view.frame.size.width : view.frame.size.height;
    CGFloat height = view.frame.size.height < view.frame.size.width ? view.frame.size.width : view.frame.size.height;
    CGRect frame = CGRectMake(0, height - width - 60, width, width);
    DBGuestureLock *lock = [[DBGuestureLock alloc] initWithFrame:frame];
    
    lock.delegate = delegate;
    lock.onPasswordSet = nil;
    lock.onGetCorrectPswd = nil;
    lock.onGetIncorrectPswd = nil;
    
    return lock;
}

+(instancetype)lockOnView:(UIView*)view onPasswordSet:(void (^ __nullable)(DBGuestureLock *lock, NSString *password))onPasswordSet onGetCorrectPswd:(void (^ __nullable)(DBGuestureLock *lock, NSString *password))onGetCorrectPswd onGetIncorrectPswd:(void (^ __nullable)(DBGuestureLock *lock, NSString *password))onGetIncorrectPswd {
    CGFloat width = view.frame.size.height > view.frame.size.width ? view.frame.size.width : view.frame.size.height;
    CGFloat height = view.frame.size.height < view.frame.size.width ? view.frame.size.width : view.frame.size.height;
    CGRect frame = CGRectMake(0, height - width - 60, width, width);
    DBGuestureLock *lock = [[DBGuestureLock alloc] initWithFrame:frame];
    
    lock.delegate = nil;
    lock.onPasswordSet = onPasswordSet;
    lock.onGetCorrectPswd = onGetCorrectPswd;
    lock.onGetIncorrectPswd = onGetIncorrectPswd;
    
    return lock;
}

-(void)setupLockThemeWithLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth  strokeColor:(UIColor*)strokeColor strokeWidth:(CGFloat)strokeWidth circleRadius:(CGFloat)circleRadius fillColor:(UIColor*)fillColor showCenterPoint:(BOOL)showCenterPoint centerPointColor:(UIColor*)centerPointColor centerPointRadius:(CGFloat)centerPointRadius fillCenterPoint:(BOOL)fillCenterPoint onState:(DBButtonState)buttonState{
    if (self.delegate) { //Work with block only
        return;
    }
    
    switch (buttonState) {
        case DBButtonStateNormal:
            self.lineColorOnStateNormal = lineColor;
            self.lineWidthOnStateNormal = lineWidth;
            self.strokeColorOnStateNormal = strokeColor;
            self.strokeWidthOnStateNormal = strokeWidth;
            self.circleRadiusOnStateNormal = circleRadius;
            self.fillColorOnStateNormal = fillColor;
            self.showCenterPointOnStateNormal = showCenterPoint;
            self.centerPointColorOnStateNormal = centerPointColor;
            self.centerPointRadiusOnStateNormal = centerPointRadius;
            self.fillCenterPointOnStateNormal = fillCenterPoint;
            break;
        case DBButtonStateSelected:
            self.lineColorOnStateSelected = lineColor;
            self.lineWidthOnStateSelected = lineWidth;
            self.strokeColorOnStateSelected = strokeColor;
            self.strokeWidthOnStateSelected = strokeWidth;
            self.circleRadiusOnStateSelected = circleRadius;
            self.fillColorOnStateSelected = fillColor;
            self.showCenterPointOnStateSelected = showCenterPoint;
            self.centerPointColorOnStateSelected = centerPointColor;
            self.centerPointRadiusOnStateSelected = centerPointRadius;
            self.fillCenterPointOnStateSelected = fillCenterPoint;
            break;
        case DBButtonStateIncorrect:
            self.lineColorOnStateIncorrect = lineColor;
            self.lineWidthOnStateIncorrect = lineWidth;
            self.strokeColorOnStateIncorrect = strokeColor;
            self.strokeWidthOnStateIncorrect = strokeWidth;
            self.circleRadiusOnStateIncorrect = circleRadius;
            self.fillColorOnStateIncorrect = fillColor;
            self.showCenterPointOnStateIncorrect = showCenterPoint;
            self.centerPointColorOnStateIncorrect = centerPointColor;
            self.centerPointRadiusOnStateIncorrect = centerPointRadius;
            self.fillCenterPointOnStateIncorrect = fillCenterPoint;
            break;
        default:
            break;
    }
    
}

//@Override
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) { // Draw 9 Lock Buttons
        [self setPropertiesByState:DBButtonStateNormal];
        _selectedButtons = [[NSMutableArray alloc] initWithCapacity:0];
        CGFloat width = frame.size.height > frame.size.width ? frame.size.width : frame.size.height;
        CGFloat spacing = width / 10; //Split into 10 Part
        CGFloat radius = spacing;
        [self setCircleRadius:radius];
        for (NSInteger i=0; i<9; i++) { //Total 9 buttons
            NSInteger row = i/3; //3 buttons for each row
            NSInteger col = i%3; //3 buttons for each column
            
            CGRect frame = CGRectMake((1+col*3)*spacing, (1+row*3)*spacing, 2*radius, 2*radius);
            DBGuestureButton *button = [[DBGuestureButton alloc] initWithFrame: frame];
            [button setTag: i+1]; // Present for password number
            [self addSubview: button];
            [self setBackgroundColor:[UIColor clearColor]];
        }
    }
    
    return self;
}

//@Override
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.currentPoint = point;
    
    for (DBGuestureButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            [button setSelected:YES];
            if (![self.selectedButtons containsObject:button]) {
                [self.selectedButtons addObject:button];
                [self setPropertiesByState:DBButtonStateSelected];
                [button setNeedsDisplay];
            }
        }
    }
    
    [self setNeedsDisplay];
}

//@Override
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.currentPoint = point;
    
    for (DBGuestureButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            [button setSelected:YES];
            if (![self.selectedButtons containsObject:button]) {
                [self.selectedButtons addObject:button];
                [self setPropertiesByState:DBButtonStateSelected];
            }
        }
    }
    
    [self setNeedsDisplay];
}

//@Override
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    //Get password
    NSMutableString *password = [[NSMutableString alloc] initWithCapacity:0];
    for (NSInteger i=0; i<[self.selectedButtons count]; i++) {
        DBGuestureButton *button = self.selectedButtons[i];
        [password appendFormat:@"%li", (long)button.tag];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *correctPswd = [defaults valueForKey:DBGuestureLockPaswd];
    if (correctPswd == nil || [correctPswd length] <= 0) {
        [defaults setValue: password forKey:DBGuestureLockPaswd];
        if (self.delegate) {
            [self.delegate guestureLock:self didSetPassword:password];
        } else {
            self.onPasswordSet(self, password);
        }
        [self setPropertiesByState:DBButtonStateNormal];
    } else if ([password isEqualToString:correctPswd]) {
        if (self.delegate) {
            [self.delegate guestureLock:self didGetCorrectPswd:password];
        } else {
            self.onGetCorrectPswd(self, password);
        }
        [self setPropertiesByState:DBButtonStateNormal];
    } else { //incorrect
        if (self.delegate) {
            [self.delegate guestureLock:self didGetIncorrectPswd:password];
        } else {
            self.onGetIncorrectPswd(self, password);
        }
        [self setPropertiesByState:DBButtonStateIncorrect];
    }
    
    DBGuestureButton *lastButton = [self.selectedButtons lastObject];
    [self setCurrentPoint:lastButton.center];
    [self setNeedsDisplay];
}

-(void)resetButtons {
    for (NSInteger i=0; i<[self.selectedButtons count]; i++) {
        DBGuestureButton *button = self.selectedButtons[i];
        [button setSelected:NO];
    }
    [self.selectedButtons removeAllObjects];
    [self setNeedsDisplay];
}

-(void)lockState:(NSArray *)states {
    NSNumber *stateNumber = [states objectAtIndex:0];
    [self setPropertiesByState:[stateNumber integerValue]];
}

-(void)setPropertiesByState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            [self setUserInteractionEnabled:YES];
            [self resetButtons];
            
            self.fillCenterPoint = NO; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(fillButtonCircleCenterPointOnState:)]) {
                    self.fillCenterPoint = [self.delegate fillButtonCircleCenterPointOnState:DBButtonStateNormal];
                }
            } else if (self.fillCenterPointOnStateNormal) {
                self.fillCenterPoint = self.fillCenterPointOnStateNormal;
            }
            
            self.showCenterPoint = NO; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(showButtonCircleCenterPointOnState:)]) {
                    self.showCenterPoint = [self.delegate showButtonCircleCenterPointOnState:DBButtonStateNormal];
                }
            } else if (self.showCenterPointOnStateNormal) {
                self.showCenterPoint = self.showCenterPointOnStateNormal;
            }
            
            self.strokeWidth = 1.f; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(widthOfButtonCircleStrokeOnState:)]) {
                    self.strokeWidth = [self.delegate widthOfButtonCircleStrokeOnState:DBButtonStateNormal];
                }
            } else if (self.strokeWidthOnStateNormal) {
                self.strokeWidth = self.strokeWidthOnStateNormal;
            }
            
            self.centerPointRadius = 0.f; //As default
            if (self.delegate){
                if ([self.delegate respondsToSelector:@selector(radiusOfButtonCircleCenterPointOnState:)]) {
                    self.centerPointRadius = [self.delegate radiusOfButtonCircleCenterPointOnState:DBButtonStateNormal];
                }
            } else if (self.centerPointColorOnStateNormal){
                self.centerPointColor = self.centerPointColorOnStateNormal;
            }
            
            self.lineWidth = 0.f;
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(lineWidthOfGuestureOnState:)]) {
                    self.centerPointRadius = [self.delegate lineWidthOfGuestureOnState:DBButtonStateNormal];
                }
            } else if (self.lineWidthOnStateNormal) {
                self.lineWidth = self.lineWidthOnStateNormal;
            }
            
            self.lineColor = [UIColor whiteColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(lineColorOfGuestureOnState:)]) {
                    self.lineColor = [self.delegate lineColorOfGuestureOnState:DBButtonStateNormal];
                }
            } else if (self.lineColorOnStateNormal) {
                self.lineColor = self.lineColorOnStateNormal;
            }
            
            //As default
            self.fillColor = [UIColor clearColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorForFillingButtonCircleOnState:)]) {
                    self.fillColor = [self.delegate colorForFillingButtonCircleOnState:DBButtonStateNormal];
                }
            } else if (self.fillColorOnStateNormal) {
                self.fillColor = self.fillColorOnStateNormal;
            }
            
            //As default
            self.strokeColor = [UIColor whiteColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorOfButtonCircleStrokeOnState:)]) {
                    self.strokeColor = [self.delegate colorOfButtonCircleStrokeOnState:DBButtonStateNormal];
                }
            } else if (self.strokeColorOnStateNormal){
                self.strokeColor = self.strokeColorOnStateNormal;
            }
            
            //As default
            self.centerPointColor = [UIColor clearColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorOfButtonCircleCenterPointOnState:)]) {
                    self.centerPointColor = [self.delegate colorOfButtonCircleCenterPointOnState:DBButtonStateNormal];
                }
            } else if (self.centerPointColorOnStateNormal){
                self.centerPointColor = self.centerPointColorOnStateNormal;
            }
            
            //self.circleRadius = self.circleRadius;
            break;
        case DBButtonStateSelected:
            self.fillCenterPoint = YES; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(fillButtonCircleCenterPointOnState:)]) {
                    self.fillCenterPoint = [self.delegate fillButtonCircleCenterPointOnState:DBButtonStateSelected];
                }
            } else if (self.fillCenterPointOnStateSelected) {
                self.fillCenterPoint = self.fillCenterPointOnStateSelected;
            }
            
            self.showCenterPoint = YES; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(showButtonCircleCenterPointOnState:)]) {
                    self.showCenterPoint = [self.delegate showButtonCircleCenterPointOnState:DBButtonStateSelected];
                }
            } else if (self.showCenterPointOnStateSelected) {
                self.showCenterPoint = self.showCenterPointOnStateSelected;
            }
            
            self.strokeWidth = 1.f; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(widthOfButtonCircleStrokeOnState:)]) {
                    self.strokeWidth = [self.delegate widthOfButtonCircleStrokeOnState:DBButtonStateSelected];
                }
            } else if (self.strokeWidthOnStateSelected) {
                self.strokeWidth = self.strokeWidthOnStateSelected;
            }
            
            self.centerPointRadius = 10.f; //As default
            if (self.delegate){
                if ([self.delegate respondsToSelector:@selector(radiusOfButtonCircleCenterPointOnState:)]) {
                    self.centerPointRadius = [self.delegate radiusOfButtonCircleCenterPointOnState:DBButtonStateSelected];
                }
            } else if (self.centerPointColorOnStateSelected){
                self.centerPointColor = self.centerPointColorOnStateSelected;
            }
            
            self.lineWidth = 2.f;
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(lineWidthOfGuestureOnState:)]) {
                    self.centerPointRadius = [self.delegate lineWidthOfGuestureOnState:DBButtonStateSelected];
                }
            } else if (self.lineWidthOnStateSelected) {
                self.lineWidth = self.lineWidthOnStateSelected;
            }
            
            self.lineColor = [UIColor whiteColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(lineColorOfGuestureOnState:)]) {
                    self.lineColor = [self.delegate lineColorOfGuestureOnState:DBButtonStateSelected];
                }
            } else if (self.lineColorOnStateSelected) {
                self.lineColor = self.lineColorOnStateSelected;
            }
            
            //As default
            self.fillColor = [UIColor lightTextColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorForFillingButtonCircleOnState:)]) {
                    self.fillColor = [self.delegate colorForFillingButtonCircleOnState:DBButtonStateSelected];
                }
            } else if (self.fillColorOnStateSelected) {
                self.fillColor = self.fillColorOnStateSelected;
            }
            
            //As default
            self.strokeColor = [UIColor whiteColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorOfButtonCircleStrokeOnState:)]) {
                    self.strokeColor = [self.delegate colorOfButtonCircleStrokeOnState:DBButtonStateSelected];
                }
            } else if (self.strokeColorOnStateSelected){
                self.strokeColor = self.strokeColorOnStateSelected;
            }
            
            //As default
            self.centerPointColor = [UIColor whiteColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorOfButtonCircleCenterPointOnState:)]) {
                    self.centerPointColor = [self.delegate colorOfButtonCircleCenterPointOnState:DBButtonStateSelected];
                }
            } else if (self.centerPointColorOnStateSelected){
                self.centerPointColor = self.centerPointColorOnStateSelected;
            }
            
            //self.circleRadius = self.circleRadius;
            break;
        case DBButtonStateIncorrect:
            [self setUserInteractionEnabled:NO];
            
            self.fillCenterPoint = YES; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(fillButtonCircleCenterPointOnState:)]) {
                    self.fillCenterPoint = [self.delegate fillButtonCircleCenterPointOnState:DBButtonStateIncorrect];
                }
            } else if (self.fillCenterPointOnStateIncorrect) {
                self.fillCenterPoint = self.fillCenterPointOnStateIncorrect;
            }
            
            self.showCenterPoint = YES; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(showButtonCircleCenterPointOnState:)]) {
                    self.showCenterPoint = [self.delegate showButtonCircleCenterPointOnState:DBButtonStateIncorrect];
                }
            } else if (self.showCenterPointOnStateIncorrect) {
                self.showCenterPoint = self.showCenterPointOnStateIncorrect;
            }
            
            self.strokeWidth = 1.f; //As default
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(widthOfButtonCircleStrokeOnState:)]) {
                    self.strokeWidth = [self.delegate widthOfButtonCircleStrokeOnState:DBButtonStateIncorrect];
                }
            } else if (self.strokeWidthOnStateIncorrect) {
                self.strokeWidth = self.strokeWidthOnStateIncorrect;
            }
            
            self.centerPointRadius = 10.f; //As default
            if (self.delegate){
                if ([self.delegate respondsToSelector:@selector(radiusOfButtonCircleCenterPointOnState:)]) {
                    self.centerPointRadius = [self.delegate radiusOfButtonCircleCenterPointOnState:DBButtonStateIncorrect];
                }
            } else if (self.centerPointColorOnStateIncorrect){
                self.centerPointColor = self.centerPointColorOnStateIncorrect;
            }
            
            self.lineWidth = 5.f;
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(lineWidthOfGuestureOnState:)]) {
                    self.centerPointRadius = [self.delegate lineWidthOfGuestureOnState:DBButtonStateIncorrect];
                }
            } else if (self.lineWidthOnStateIncorrect) {
                self.lineWidth = self.lineWidthOnStateIncorrect;
            }
            
            self.lineColor = [UIColor orangeColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(lineColorOfGuestureOnState:)]) {
                    self.lineColor = [self.delegate lineColorOfGuestureOnState:DBButtonStateIncorrect];
                }
            } else if (self.lineColorOnStateIncorrect) {
                self.lineColor = self.lineColorOnStateIncorrect;
            }
            
            //As default
            self.fillColor = [UIColor lightTextColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorForFillingButtonCircleOnState:)]) {
                    self.fillColor = [self.delegate colorForFillingButtonCircleOnState:DBButtonStateIncorrect];
                }
            } else if (self.fillColorOnStateIncorrect) {
                self.fillColor = self.fillColorOnStateIncorrect;
            }
            
            //As default
            self.strokeColor = [UIColor orangeColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorOfButtonCircleStrokeOnState:)]) {
                    self.strokeColor = [self.delegate colorOfButtonCircleStrokeOnState:DBButtonStateIncorrect];
                }
            } else if (self.strokeColorOnStateIncorrect){
                self.strokeColor = self.strokeColorOnStateIncorrect;
            }
            
            //As default
            self.centerPointColor = [UIColor orangeColor];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(colorOfButtonCircleCenterPointOnState:)]) {
                    self.centerPointColor = [self.delegate colorOfButtonCircleCenterPointOnState:DBButtonStateIncorrect];
                }
            } else if (self.centerPointColorOnStateIncorrect){
                self.centerPointColor = self.centerPointColorOnStateIncorrect;
            }
            
            //self.circleRadius = self.circleRadius;
            [self performSelector:@selector(lockState:) withObject:[NSArray arrayWithObject:[NSNumber numberWithInteger:DBButtonStateNormal]] afterDelay:1.f];
            break;
        default:
            break;
    }
}

@end
