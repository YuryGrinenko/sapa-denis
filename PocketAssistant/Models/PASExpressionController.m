//
//  PASExpressionController.m
//  PocketAssistant
//
//  Created by Sapa Denys on 06.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASExpressionController.h"
#import "PASExpressionFormatter.h"


static const NSInteger kPASEqualCode = '=';
static const NSInteger kPASClearCode = 'C';

typedef NS_ENUM(NSInteger, PASExpressionControllerState) {
	PASExpressionControllerStatePrint,
	PASExpressionControllerStateEnterFirstOperand,
	PASExpressionControllerStateEnterOperator,
	PASExpressionControllerStateEnterSecondOperand
};

@interface PASExpressionController ()

@property (nonatomic) PASExpressionControllerState controllerState;
@property (nonatomic, strong) PASExpressionModel *operationModel;

@property (nonatomic, copy) NSString *character;

@end

@implementation PASExpressionController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _operationModel = [PASExpressionModel new];
		_controllerState = PASExpressionControllerStatePrint;
		[_operationModel addListener:self];
    }
    return self;
}

- (void)dealloc
{
	[_operationModel removeListener:self];
}



- (void)fillModelWithNextCharacter:(NSString *)character
{
	if ([character characterAtIndex:0] == kPASClearCode) {
		
		self.controllerState = PASExpressionControllerStatePrint;
		[self.operationModel cleanModel];
		return;
	}
	
	self.character = character;
	
	[self callStateSwitcher];
}

#pragma mark - State Machine

- (void)callStateSwitcher
{
	switch (self.controllerState) {
		case PASExpressionControllerStatePrint:
			[self callPrintState];
			break;
			
		case PASExpressionControllerStateEnterFirstOperand:
			[self callEnterFirstOperandState];
			break;
			
		case PASExpressionControllerStateEnterOperator:
			[self callEnterOperatorState];
			break;
			
		case PASExpressionControllerStateEnterSecondOperand:
			[self callEnterSecondOperandState];
			break;
			
		default:
			break;
	}
}

- (void)callPrintState
{
	if ([self isCharacterNumber:self.character]) {
		[self.operationModel cleanModel];
		self.controllerState = PASExpressionControllerStateEnterFirstOperand;
		[self callStateSwitcher];
	}
}

- (void)callEnterFirstOperandState
{
	if ([self isCharacterNumber:self.character]) {
		[self.operationModel appendToFirstOperand:self.character];
	} else  if ([self.character characterAtIndex:0] != kPASEqualCode) {
		self.controllerState = PASExpressionControllerStateEnterOperator;
		[self callStateSwitcher];
	} else if ([self.character characterAtIndex:0] == kPASEqualCode) {
		self.controllerState = PASExpressionControllerStatePrint;
	}
}

- (void)callEnterOperatorState
{
	[self.operationModel addOperator:self.character];
	self.controllerState = PASExpressionControllerStateEnterSecondOperand;
}

- (void)callEnterSecondOperandState
{
	if ([self isCharacterNumber:self.character]) {
		[self.operationModel appendToSecondOperand:self.character];
	} else if ([self.character characterAtIndex:0] == kPASEqualCode || self.operationModel.secondOperand.length) {
			self.controllerState = PASExpressionControllerStatePrint;
			[self.operationModel calculateResult];
	}
}

#pragma mark -

- (BOOL)isCharacterNumber:(NSString *)character
{
	return isnumber([character characterAtIndex:0]);
}

#pragma mark - Key-Value Observing

+ (BOOL)automaticallyNotifiesObserversOfFormattedModelPresentation
{
	return NO;
}

#pragma mark - PASExpressionModelObserver

- (void)expressionModelDidChange:(PASExpressionModel *)model
{
	[self willChangeValueForKey:@"formattedModelPresentation"];
	_formattedModelPresentation = [PASExpressionFormatter formattedStringFromExpression:model];
	[self didChangeValueForKey:@"formattedModelPresentation"];
}

@end
