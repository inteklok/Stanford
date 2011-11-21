//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Gregor Tomasevic on 2011-11-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (nonatomic,strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil)
        _operandStack =[[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    }
    else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if(divisor)  //Check for div by zero
            result = [self popOperand] / divisor;
    }
    else if ([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    }
    else if ([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    }
    else if ([operation isEqualToString:@"π"]) {
        double pi = 3.141592;
        result = pi;
    }
    else if ([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    }


    
    [self pushOperand:result];
    
    return result;
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) 
        [self.operandStack removeLastObject];
    
    return [operandObject doubleValue];
}

- (void)clearBrain {
    [self.operandStack removeAllObjects];
}

@end
