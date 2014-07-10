//
//  PASExpressionModel.h
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PASExpressionModel;

@protocol PASExpressionModelObserver <NSObject>

- (void)expressionModelDidChange:(PASExpressionModel *)model;

@end

@interface PASExpressionModel : NSObject

@property (nonatomic, copy) NSString *firstOperand;
@property (nonatomic, copy) NSString *secondOperand;
@property (nonatomic, copy) NSString *baseOperator;

@property (nonatomic, copy) NSString *result;

@property (nonatomic, readonly, getter = isEmpty) BOOL empty;

- (void)cleanModel;

- (void)calculateResult;

- (void)appendToFirstOperand:(NSString *)character;
- (void)addOperator:(NSString *)baseOperator;
- (void)appendToSecondOperand:(NSString *)character;

@end

@interface PASExpressionModel (ExpressionModelObserving)

- (void)addListener:(id<PASExpressionModelObserver>)listener;
- (void)removeListener:(id<PASExpressionModelObserver>)listener;

@end
