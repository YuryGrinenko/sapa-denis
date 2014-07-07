//
//  PASExpressionController.m
//  PocketAssistant
//
//  Created by Sapa Denys on 06.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASExpressionController.h"

typedef NS_ENUM(NSInteger, PASExpressionControllerState) {
	PASExpressionControllerStatePrint,
	PASExpressionControllerStateEnterFirstOperand,
	PASExpressionControllerStateEnterOperator,
	PASExpressionControllerStateEnterSecondOperand
};

@interface PASExpressionController ()

@property (nonatomic) PASExpressionControllerState controllerState;
@property (nonatomic, strong) PASExpressionModel *operationModel;

@end

@implementation PASExpressionController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _operationModel = [PASExpressionModel new];
		_controllerState = PASExpressionControllerStatePrint;
    }
    return self;
}

- (void)fillModelWithNextCharacter:(NSString *)character
{
	switch (self.controllerState) {
		case PASExpressionControllerStatePrint:
			
//			break;
			
		case PASExpressionControllerStateEnterFirstOperand:
		{
			self.controllerState = PASExpressionControllerStateEnterFirstOperand;
			
			if ([self isCharacterNumber:character]) {
				[self.operationModel appendToFirstOperand:character];
			} else {
				self.controllerState = PASExpressionControllerStateEnterOperator;
				
			}
			
			break;
		}
			
		case PASExpressionControllerStateEnterOperator:
			break;
			
		case PASExpressionControllerStateEnterSecondOperand:
			break;
			
			
		default:
			break;
	}
	
	
	NSInteger characterValue = [character integerValue];
	if (characterValue) {
		
	}
}

- (BOOL)isCharacterNumber:(NSString *)character
{
	return isnumber([character characterAtIndex:0]);
}

- (void) fillFirstOperand
{
	
}

@end
