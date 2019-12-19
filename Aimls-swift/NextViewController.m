//
//  NextViewController.m
//  Aimls-swift
//
//  Created by 中创 on 2019/12/6.
//  Copyright © 2019 LS. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testFuncWithOutParameter1:@"1" Outparameter2:@"2"];
}

- (NSArray *)testFuncWithOutParameter1:(NSString *)parameter1 Outparameter2:(NSString *)parameter2{
    return @[parameter1, parameter2];
}

@end
