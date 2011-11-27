//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Gregor Tomasevic on 2011-11-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *strip;
@property (weak, nonatomic) IBOutlet UILabel *infixStrip;

- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)enterPressed;
- (IBAction)clearPressed;

@end
