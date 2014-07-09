//
//  PASExpressionModel.h
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PASExpressionModel;

@protocol ExpressionModelObserver <NSObject>

- (void)expressionModelDidChange:(PASExpressionModel *)model;

@end

@interface PASExpressionModel : NSObject

@property (nonatomic, copy) NSString *firstOperand;
@property (nonatomic, copy) NSString *secondOperand;
@property (nonatomic, copy) NSString *baseOperator;
@property (nonatomic, readonly, getter = isEmpty) BOOL empty;

@property (nonatomic) NSInteger *result;

//@property (nonatomic, readonly, copy) NSString *formattedExpression;

- (NSInteger)calculateResult;

- (void)appendToFirstOperand:(NSString *)character;
- (void)addOperator:(NSString *)baseOperator;
- (void)appendToSecondOperand:(NSString *)character;

@end

@interface PASExpressionModel (ExpressionModelObserving)

- (void)addListener:(id<ExpressionModelObserver>)listener;
- (void)removeListener:(id<ExpressionModelObserver>)listener;

@end
