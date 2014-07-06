//
//  PASExpressionModel.h
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PASExpressionModel : NSObject

@property (nonatomic) NSInteger *firstOperand;
@property (nonatomic) NSInteger *secondOperand;
@property (nonatomic, copy) NSString *baseOperator;

@property (nonatomic) NSInteger *result;

- (NSInteger)calculateResult;

@end
