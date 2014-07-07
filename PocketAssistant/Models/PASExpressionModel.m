//
//  PASExpressionModel.m
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASExpressionModel.h"

@implementation PASExpressionModel

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
		self.firstOperand = [self.firstOperand stringByAppendingString:character];
	}
}

@end
