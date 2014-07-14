//
//  PASExpressionController.h
//  PocketAssistant
//
//  Created by Sapa Denys on 06.07.14.
//  Copyright (c) 2014 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PASExpressionModel.h"

@interface PASExpressionController : NSObject <PASExpressionModelObserver>

#warning Зачем это объявление здесь? Перенеси его в *.m

#pragma якщо зробити приватним, view controller не зможе підписатись на зміни цього property через key-value observing
@property (nonatomic, copy, readonly) NSString *formattedModelPresentation;

- (void)fillModelWithNextCharacter:(NSString *)character;

@end
