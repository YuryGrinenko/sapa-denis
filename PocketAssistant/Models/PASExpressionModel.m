//
//  PASExpressionModel.m
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASExpressionModel.h"

@implementation PASExpressionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _empty = YES;
		_firstOperand = @"";
		_secondOperand = @"";
		_baseOperator = @"";
    }
    return self;
}

- (void)clearModel
{
	
}

- (NSInteger)calculateResult
{
	return 0;
}

+ (NSSet *)keyPathsForValuesAffectingFormattedExpression
{
	return [NSSet setWithArray:@[@"firstOperand", @"secondOperand", @"baseOperator"]];
}

- (void)appendToFirstOperand:(NSString *)character
{
	if (self.firstOperand.length || [character integerValue]) {
		_empty = NO;
		self.firstOperand = [self.firstOperand stringByAppendingString:character];
	}
}

- (void)addOperator:(NSString *)baseOperator
{
	if (!self.baseOperator.length) {
		self.baseOperator = baseOperator;
	}
}

- (void)appendToSecondOperand:(NSString *)character
{
	if (self.secondOperand.length || [character integerValue]) {
		_empty = NO;
		self.secondOperand = [self.secondOperand stringByAppendingString:character];
	}
}

- (void)didChangeValueForKey:(NSString *)key
{
	[super didChangeValueForKey:key];
	//TODO:
}

@end
