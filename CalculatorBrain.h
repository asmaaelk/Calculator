//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Asmaa Elkeurti on 1/31/14.
//  Copyright (c) 2014 Asmaa Elkeurti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearScreen;

@end
