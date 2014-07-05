//
//  PASExpressionFormatter.h
//  PocketAssistant
//
//  Created by Sapa Denys on 05.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PASExpressionModel;

@interface PASExpressionFormatter : NSObject

+ (NSString *)formattedStringFromExpression:(PASExpressionModel *)model;

@end
