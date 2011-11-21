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
        self.strip.text = [self.strip.text stringByAppendingString:digit];
        }
    }
    else
    {
        self.display.text = digit;
        self.strip.text = [self.strip.text stringByAppendingString:digit];
        
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}


- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    self.strip.text = [self.strip.text stringByAppendingString:sender.currentTitle];
    self.strip.text = [self.strip.text stringByAppendingString:@" "];
    
    double result = [self.brain performOperation:sender.currentTitle];
    
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.strip.text = [self.strip.text stringByAppendingString:@" "];
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.strip.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain clearBrain];
}

- (void)viewDidUnload {
    [self setStrip:nil];
    [super viewDidUnload];
}
@end
