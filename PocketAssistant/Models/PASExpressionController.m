//
//  PASExpressionController.m
//  PocketAssistant
//
//  Created by Sapa Denys on 06.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASExpressionController.h"
#import "PASExpressionFormatter.h"

typedef NS_ENUM(NSInteger, PASExpressionControllerState) {
	PASExpressionControllerStatePrint,
	PASExpressionControllerStateEnterFirstOperand,
	PASExpressionControllerStateEnterOperator,
	PASExpressionControllerStateEnterSecondOperand
};

static NSInteger const kEqualCode = '=';

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
			[PASExpressionFormatter formattedStringFromExpression:self.operationModel];
			self.controllerState = PASExpressionControllerStateEnterFirstOperand;
			break;
			
		case PASExpressionControllerStateEnterFirstOperand:
		{
			if ([self isCharacterNumber:character]) {
				[self.operationModel appendToFirstOperand:character];
			} else {
				self.controllerState = PASExpressionControllerStateEnterOperator;
				
				[self.operationModel addOperator:character];
			}
			break;
		}
			
		case PASExpressionControllerStateEnterOperator:
			if ([self isCharacterNumber:character]) {
				self.controllerState = PASExpressionControllerStateEnterSecondOperand;
				[self.operationModel appendToSecondOperand:character];
			}
			break;
			
		case PASExpressionControllerStateEnterSecondOperand:
			if ([self isCharacterNumber:character]) {
				[self.operationModel appendToSecondOperand:character];
			} else {
				self.controllerState = PASExpressionControllerStatePrint;
				
				[self.operationModel addOperator:character];
			}
			break;
			
			
		default:
			break;
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
