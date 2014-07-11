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
		[PASExpressionFormatter formattedStringFromExpression:self.operationModel];
		return;
	}
	
	switch (self.controllerState) {
		case PASExpressionControllerStatePrint:
			[PASExpressionFormatter formattedStringFromExpression:self.operationModel];
			
			if ([self isCharacterNumber:character]) {
				[self.operationModel cleanModel];
				self.controllerState = PASExpressionControllerStateEnterFirstOperand;
				[self.operationModel appendToFirstOperand:character];
			}
			break;
			
		case PASExpressionControllerStateEnterFirstOperand:
		{
			if ([self isCharacterNumber:character]) {
				[self.operationModel appendToFirstOperand:character];
			} else  if ([character characterAtIndex:0] != kPASEqualCode) {
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
				if ([character characterAtIndex:0] == kPASEqualCode) {
					self.controllerState = PASExpressionControllerStatePrint;
					[self.operationModel calculateResult];
					[PASExpressionFormatter formattedStringFromExpression:self.operationModel];
				}
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
