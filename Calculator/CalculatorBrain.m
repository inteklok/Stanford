//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Gregor Tomasevic on 2011-11-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (nonatomic,strong) NSMutableArray *programStack;

+ (NSString *)descriptionOfProgram:(id)program;
+ (NSString *)descriptionOfTopOfStack:(NSMutableArray *)stack;
+ (BOOL)isOperation:(NSString *)operation;
+ (BOOL)isSingleOperandOperation:(NSString *)operation;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil)
        _programStack =[[NSMutableArray alloc] init];
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) 
        stack = [program mutableCopy];
    
    return [self descriptionOfTopOfStack:stack];
}


+ (NSString *)descriptionOfTopOfStack:(NSMutableArray *)stack {
    
    NSString *description = @"";
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        description = [topOfStack stringValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        if ([self isOperation:topOfStack])
        {
        if ([self isSingleOperandOperation:topOfStack]) {
            description = [NSString stringWithFormat:@"%@(%@)", topOfStack, [self descriptionOfTopOfStack:stack]];
        }
                    
             else {
                 NSString *secondOperand = [self descriptionOfTopOfStack:stack];
                 description = [NSString stringWithFormat:@"(%@ %@ %@)", [self descriptionOfTopOfStack:stack], topOfStack, secondOperand];
             }
        }
    
    else description = topOfStack;
        
    }
    
    return description;
}

+ (BOOL)isOperation:(NSString *)operation {
    NSSet *operations = [NSSet setWithObjects:@"sqrt", @"sin", @"com", @"+", @"-", @"*", @"/", nil];
    
    return[operations containsObject:operation];
}

+ (BOOL)isSingleOperandOperation:(NSString *)operation {
    NSSet *singleOperandOperations = [NSSet setWithObjects:@"sqrt", @"sin", @"com", nil];
    
    return[singleOperandOperations containsObject:operation];
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}


+ (double)popOperandOffProgramStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack] +
            [self popOperandOffProgramStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack] *
            [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        } else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOffProgramStack:stack]);
        }     else if ([operation isEqualToString:@"π"]) {
            double pi = 3.141592;
            result = pi;
        }


    }
    
    return result;
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

- (double)popOperand {
    NSNumber *operandObject = [self.programStack lastObject];
    if (operandObject) 
        [self.programStack removeLastObject];
    
    return [operandObject doubleValue];
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    NSLog(@"Description of program: %@", [self descriptionOfProgram:program]);
    return [self popOperandOffProgramStack:stack];
}

- (void)clearBrain {
    [self.programStack removeAllObjects];
}

@end
