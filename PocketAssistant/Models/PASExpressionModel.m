//
//  PASExpressionModel.m
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import "PASExpressionModel.h"

typedef NS_ENUM(NSInteger, PASBaseOperatorsCode) {
	PASBaseOperatorsCodePlus = 43,
	PASBaseOperatorsCodeMinus = 8211,
	PASBaseOperatorsCodeMultiply = 10005,
	PASBaseOperatorsCodeDelivery = 47,
};

static const int kMaxLengthOfNumbersInOperand = 9;

@interface PASExpressionModel ()

@property (nonatomic, strong) NSHashTable *listeners;

@end

@implementation PASExpressionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _empty = YES;
		_listeners = [NSHashTable weakObjectsHashTable];
		_firstOperand = @"";
		_secondOperand = @"";
		_baseOperator = @"";
		_result = @"";
    }
    return self;
}

- (void)cleanModel
{
	_empty = YES;
	self.firstOperand = @"";
	self.secondOperand = @"";
	self.baseOperator = @"";
	self.result = @"";
}

- (void)calculateResult
{
	int symbolCode = [self.baseOperator characterAtIndex:0];
	
	switch (symbolCode) {
		case PASBaseOperatorsCodePlus:
			self.result = [NSString stringWithFormat:@"%i", [self.firstOperand integerValue] + [self.secondOperand integerValue]];
			break;
			
		case PASBaseOperatorsCodeMinus:
			self.result = [NSString stringWithFormat:@"%i", [self.firstOperand integerValue] - [self.secondOperand integerValue]];
			break;
			
		case PASBaseOperatorsCodeMultiply:
			self.result = [NSString stringWithFormat:@"%i", [self.firstOperand integerValue] * [self.secondOperand integerValue]];
			break;
			
		case PASBaseOperatorsCodeDelivery:
			self.result = [NSString stringWithFormat:@"%.2f", [self.firstOperand integerValue] / ([self.secondOperand integerValue] * 1.)];
			break;
			
		default:
			break;
	}

}

+ (NSSet *)keyPathsForValuesAffectingFormattedExpression
{
	return [NSSet setWithArray:@[@"firstOperand", @"secondOperand", @"baseOperator", @"result"]];
}

- (void)appendToFirstOperand:(NSString *)character
{
	if (self.firstOperand.length || [character integerValue]) {
		if (self.firstOperand.length < kMaxLengthOfNumbersInOperand) {
			_empty = NO;
			self.firstOperand = [self.firstOperand stringByAppendingString:character];
		}
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
		if (self.firstOperand.length < kMaxLengthOfNumbersInOperand) {
			_empty = NO;
			self.secondOperand = [self.secondOperand stringByAppendingString:character];
		}
	}
}

- (void)didChangeValueForKey:(NSString *)key
{
	[super didChangeValueForKey:key];
	for (id <PASExpressionModelObserver> listener in self.listeners)
    {
        if ([listener respondsToSelector:@selector(expressionModelDidChange:)])
        {
            [listener expressionModelDidChange:self];
        }
    }
}

#pragma mark - PASExpressionModel Setters

- (void)setFirstOperand:(NSString *)firstOperand
{
	[self willChangeValueForKey:@"firstOperand"];
	_firstOperand = firstOperand;
	[self didChangeValueForKey:@"firstOperand"];
}

- (void)setSecondOperand:(NSString *)secondOperand
{
	[self willChangeValueForKey:@"secondOperand"];
	_secondOperand = secondOperand;
	[self didChangeValueForKey:@"secondOperand"];
}

- (void)setBaseOperator:(NSString *)baseOperator
{
	[self willChangeValueForKey:@"baseOperator"];
	_baseOperator = baseOperator;
	[self didChangeValueForKey:@"baseOperator"];
}

- (void)setResult:(NSString *)result
{
	[self willChangeValueForKey:@"result"];
	_result = result;
	[self didChangeValueForKey:@"result"];
}

#pragma mark -

- (void)addListener:(id <PASExpressionModelObserver>)listener
{
    NSParameterAssert([listener conformsToProtocol:@protocol(PASExpressionModelObserver)]);
//    NSAssert(!self.isNotifying, @"Cannot support mutation during notification");
    [self.listeners addObject:listener];
}

- (void)removeListener:(id <PASExpressionModelObserver>)listener
{
//    NSAssert(!self.isNotifying, @"Cannot support mutation during notification");
    [self.listeners removeObject:listener];
}

@end
