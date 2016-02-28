//
//  ViewController.m
//  Demo
//
//  Created by Fury on 2/28/16.
//  Copyright © 2016 http://i36.Me/. All rights reserved.
//

#import "ViewController.h"
#import "DBGuestureLock.h"

@interface ViewController ()<DBGuestureLockDelegate>

@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [DBGuestureLock clearGuestureLockPassword]; //for test
    
    DBGuestureLock *lock = [DBGuestureLock lockOnView:self.view delegate:self];
    [self.view addSubview:lock];
    self.label.text = @"Please set your password:"; //for test
    [self.view setBackgroundColor:[UIColor colorWithRed:0.133 green:0.596 blue:0.933 alpha:1.00]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DBGuestureLockDelegate

-(void)guestureLock:(DBGuestureLock *)lock didSetPassword:(NSString *)password {
    //NSLog(@"Password set: %@", password);
    if (lock.firstTimeSetupPassword == nil) {
        lock.firstTimeSetupPassword = password;
        NSLog(@"varify your password");
        self.label.text = @"Enter your password again:";
    }
}

-(void)guestureLock:(DBGuestureLock *)lock didGetCorrectPswd:(NSString *)password {
    //NSLog(@"Password correct: %@", password);
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
    //NSLog(@"Password incorrect: %@", password);
    if (![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
        NSLog(@"Error: password not equal to first setup!");
        self.label.text = @"Not equal to first setup!";
    } else {
        NSLog(@"login failed");
        self.label.text = @"login failed!";
    }
}

@end
