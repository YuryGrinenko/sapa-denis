//
//  PASViewController.m
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASViewController.h"

@interface PASViewController ()

@property (weak, nonatomic) IBOutlet UILabel *expressionLabel;

@end

@implementation PASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.expressionLabel setBaselineAdjustment:UIBaselineAdjustmentNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
