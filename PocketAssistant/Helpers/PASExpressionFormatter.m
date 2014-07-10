//
//  PASExpressionFormatter.m
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASExpressionFormatter.h"
#import "PASExpressionModel.h"

@implementation PASExpressionFormatter

+ (NSString *)formattedStringFromExpression:(PASExpressionModel *)model;
{
	NSString *formattedResult = @"0";
	
	if ([model isEmpty]) {
		NSLog(@"%@", formattedResult);
		return formattedResult;
	}
	
	formattedResult = @"%@";// [formattedResult stringByAppendingString:@"%@"];
	formattedResult = [NSString stringWithFormat:formattedResult, model.firstOperand];
	
	if (!model.baseOperator.length) {
		NSLog(@"%@", formattedResult);
		return formattedResult;
	}
	
	formattedResult = [formattedResult stringByAppendingString:@" %@"];
	formattedResult = [NSString stringWithFormat:formattedResult, model.baseOperator];
	
	if (!model.secondOperand.length) {
		NSLog(@"%@", formattedResult);
		return formattedResult;
	}
	
	formattedResult = [formattedResult stringByAppendingString:@" %@"];
	formattedResult = [NSString stringWithFormat:formattedResult, model.secondOperand];
	
	if (!model.result.length) {
		NSLog(@"%@", formattedResult);
		return formattedResult;
	}
	
	formattedResult = [formattedResult stringByAppendingString:@" = %@"];
	formattedResult = [NSString stringWithFormat:formattedResult, model.result];
	
	NSLog(@"%@", formattedResult);
	
	return formattedResult;
}

@end
