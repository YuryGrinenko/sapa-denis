//
//  PASViewController.m
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASViewController.h"
#import "PASExpressionController.h"

@interface PASViewController ()

@property (nonatomic, weak) IBOutlet UILabel *expressionLabel;
@property (nonatomic, strong) PASExpressionController *expressionController;

@end

@implementation PASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[_expressionLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
	_expressionLabel.text = @"0";
	
	_expressionController = [PASExpressionController new];
	[_expressionController addObserver:self forKeyPath:NSStringFromSelector(@selector(formattedModelPresentation))
							   options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
							   context:nil];
}

- (void)dealloc
{
    [_expressionController removeObserver:self forKeyPath:NSStringFromSelector(@selector(formattedModelPresentation))];
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
	
	[self.expressionController fillModelWithNextCharacter:title];
//	self.expressionLabel.text = [self.expressionLabel.text stringByAppendingString:title];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:NSStringFromSelector(@selector(formattedModelPresentation))]) {
//		self.expressionLabel.text = [change objectForKey:NSKeyValueChangeNewKey];
	}
}

@end
