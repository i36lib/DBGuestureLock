//
//  DBGuestureButton.m
//  DBGuestureLock
//
//  Created by DeBao.Wu on 2/27/16.
//  Email: i36.lib@gmail.com    QQ: 754753371
//  Copyright © 2016 http://i36.Me/. All rights reserved.
//  Github地址: https://github.com/i36lib/DBGuestureLock/

#import "DBGuestureLock.h"
#import "DBGuestureButton.h"

@implementation DBGuestureButton

//Override
-(instancetype)init {
    self = [super init];
    if (self) {
        [self setUserInteractionEnabled:NO];
    }
    
    return self;
}

//Override
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUserInteractionEnabled:NO];
    }
    
    return self;
}

//Override
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:NO];
    }
    
    return self;
}

//Override, Draw the button
-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    __weak DBGuestureLock *glv = nil;
    if ([self.superview isKindOfClass:[DBGuestureLock class]]) {
        glv = (DBGuestureLock *)self.superview;
    }
    
    CGFloat width = rect.size.height > rect.size.width ? rect.size.width : rect.size.height;
    CGFloat radius = (width - 2*glv.strokeWidth)/2;
    
    //if glv.circleRadius (from user) grater than radius,
    //it may cause the circle be draw out of the button.
    if (radius > (glv.circleRadius - glv.strokeWidth)) {
         radius = glv.circleRadius - glv.strokeWidth;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, glv.strokeWidth);
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    //CGPoint centerPoint = CGPointMake(radius+glv.strokeWidth, radius+glv.strokeWidth);
    CGFloat startAngle = -((CGFloat)M_PI / 2); // 90 degrees
    CGFloat endAngle = ((2 * (CGFloat)M_PI) + startAngle);
    [glv.strokeColor setStroke];
    CGContextAddArc(context, centerPoint.x, centerPoint.y, radius+glv.strokeWidth/2, startAngle, endAngle, 0); //0:counterclockwise, 1:clockwise
    CGContextStrokePath(context);

    if (glv.showCenterPoint) {
        [glv.fillColor set];
        CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, startAngle, endAngle, 0); //0:counterclockwise, 1:clockwise
        CGContextFillPath(context);
        
        if (glv.fillCenterPoint) {
            [glv.centerPointColor set];
        } else {
            [glv.centerPointColor setStroke];
        }
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, glv.centerPointRadius, startAngle, endAngle, 0); //0:counterclockwise, 1:clockwise
        if (glv.fillCenterPoint) {
            CGContextFillPath(context);
        } else {
            CGContextStrokePath(context);
        }
    }
}

@end
