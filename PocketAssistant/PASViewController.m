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
	
	unichar a = [title characterAtIndex:0];
	[NSString stringWithCharacters:&a length:1];
	
	[self.expressionController fillModelWithNextCharacter:title];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:NSStringFromSelector(@selector(formattedModelPresentation))]) {
		NSString *changedValue = [change objectForKey:NSKeyValueChangeNewKey];
		self.expressionLabel.text = [changedValue isKindOfClass:[NSNull class]] ? @"0" : changedValue;
	}
}

@end
