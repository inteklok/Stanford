//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Gregor Tomasevic on 2011-11-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize strip = _strip;
@synthesize infixStrip = _infixStrip;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
        
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = sender.currentTitle;
    
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
    NSRange range = [self.display.text rangeOfString:@"."];
    
        if ((![sender.currentTitle isEqualToString:@"."]) || (range.location == NSNotFound))
            {
            self.display.text = [self.display.text stringByAppendingString:digit];
            }
    }
    else
    {
        self.display.text = digit;
        
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}


- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    self.strip.text = [self.strip.text stringByAppendingFormat:@"%@ ",sender.currentTitle];
    
    double result = [self.brain performOperation:sender.currentTitle];
    
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    self.infixStrip.text = [CalculatorBrain descriptionOfProgram:self.brain.program];
    
}

- (IBAction)enterPressed {
    self.strip.text = [self.strip.text stringByAppendingFormat:@"%@ ",self.display.text];
    [self.brain pushOperand:[self.display.text doubleValue]];
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.strip.text = @"";
    self.infixStrip.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain clearBrain];
}

- (void)viewDidUnload {
    [self setStrip:nil];
    [self setInfixStrip:nil];
    [super viewDidUnload];
}
@end
