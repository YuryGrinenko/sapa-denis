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
	PASBaseOperatorsCodeDivide = 47,
};

static const int kMaxLengthOfNumbersInOperand = 9;

@interface PASExpressionModel ()

@property (nonatomic, strong) NSHashTable *listeners;

@property (nonatomic, copy) NSString *firstOperand;
@property (nonatomic, copy) NSString *secondOperand;
@property (nonatomic, copy) NSString *baseOperator;

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
	

	double doubleValueOfFirstOperand = [self.firstOperand doubleValue];
	double doubleValueOfSecondOperand = [self.secondOperand doubleValue];
	double doubleValueOfResult = 0.;
	
	switch (symbolCode) {
		case PASBaseOperatorsCodePlus:
			doubleValueOfResult = doubleValueOfFirstOperand + doubleValueOfSecondOperand;
			break;
			
		case PASBaseOperatorsCodeMinus:
			doubleValueOfResult = doubleValueOfFirstOperand - doubleValueOfSecondOperand;
			break;
			
		case PASBaseOperatorsCodeMultiply:
			doubleValueOfResult = doubleValueOfFirstOperand * doubleValueOfSecondOperand;
			break;
			
		case PASBaseOperatorsCodeDivide:
			doubleValueOfResult = doubleValueOfFirstOperand / doubleValueOfSecondOperand;
			break;
			
		default:
			break;
	}
	
	NSNumber *resultNumberPresentation = [NSNumber numberWithDouble:doubleValueOfResult];
	
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	
	self.result = [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:resultNumberPresentation]];
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
		if (self.secondOperand.length < kMaxLengthOfNumbersInOperand) {
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

#warning Метод никем не используется
#pragma Використовується для key-value observing`а. Вказані поля, зміна яких вимагає реакції в model controller`і
+ (NSSet *)keyPathsForValuesAffectingFormattedExpression
{
	return [NSSet setWithArray:@[@"firstOperand", @"secondOperand", @"baseOperator", @"result"]];
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

#pragma mark - Observable

- (void)addListener:(id <PASExpressionModelObserver>)listener
{
    NSParameterAssert([listener conformsToProtocol:@protocol(PASExpressionModelObserver)]);
    [self.listeners addObject:listener];
}

- (void)removeListener:(id <PASExpressionModelObserver>)listener
{
    [self.listeners removeObject:listener];
}

@end
