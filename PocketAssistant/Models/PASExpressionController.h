//
//  PASExpressionController.h
//  PocketAssistant
//
//  Created by Sapa Denys on 06.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PASExpressionModel.h"

typedef NS_ENUM(NSInteger, PASBaseOperatorsCode) {
	PASBaseOperatorsCodePlus = 43,
	PASBaseOperatorsCodeMinus = 8211,
	PASBaseOperatorsCodeMultiply = 10005,
	PASBaseOperatorsCodeDelivery = 47,
};

@interface PASExpressionController : NSObject

- (void)fillModelWithNextCharacter:(NSString *)character;

@end
