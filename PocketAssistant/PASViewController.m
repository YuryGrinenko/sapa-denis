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
	[self.expressionLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
	self.expressionLabel.text = @"0";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)touchPanelButton:(UIButton *)sender
{
	NSString *title = sender.titleLabel.text;
	NSInteger intValue = [title integerValue];
	
	int symbolCode = [title characterAtIndex:0];
	
	NSLog(@"symbol code %d", symbolCode);
	
	if (intValue) {
		NSLog(@"Integer %d", intValue);
	}
	self.expressionLabel.text = [self.expressionLabel.text stringByAppendingString:title];
}

@end
