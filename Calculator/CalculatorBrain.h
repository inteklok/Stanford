//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Gregor Tomasevic on 2011-11-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (double)popOperand;
- (void)clearBrain;

@end
