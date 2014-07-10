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

@property (nonatomic, copy, readonly) NSString *formattedModelPresentation;

- (void)fillModelWithNextCharacter:(NSString *)character;

@end
