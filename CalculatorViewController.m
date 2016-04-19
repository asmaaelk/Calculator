//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Asmaa Elkeurti on 1/27/14.
//  Copyright (c) 2014 Asmaa Elkeurti. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userPressedClear;
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;

@end

@implementation CalculatorViewController


@synthesize userPressedClear;
@synthesize display;
@synthesize operationLabel;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain= _brain;

- (CalculatorBrain *)brain {
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}



- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if ([digit isEqualToString:@"."]){
        NSRange range = [self.display.text rangeOfString:@"."];
        if(range.location != NSNotFound){
            return;
        }
    }
    if (!userPressedClear) {
        self.operationLabel.text = [self.operationLabel.text stringByAppendingString:digit];
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:digit];
            
        } else {
            self.display.text = digit;
            userIsInTheMiddleOfEnteringANumber = YES;
            
        }
        
        
    } else{
        self.operationLabel.text = digit;
        userPressedClear = NO;
        
    }
    
    
    NSLog(@"userTouched %@", digit);
}



- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
}

- (IBAction)clearPressed:(id)sender {
    self.operationLabel.text = @"";
    self.display.text = @"";
    [self.brain clearScreen];
    self.userPressedClear = NO;
    
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    
    }
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:(operation)];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    if (!userPressedClear) {
        self.operationLabel.text = [self.operationLabel.text stringByAppendingString: [NSString stringWithFormat:@" %@ ", operation]];
        self.operationLabel.text = [self.operationLabel.text stringByAppendingString:@" = "];
        
    }
    else {
        self.operationLabel.text = [NSString stringWithFormat:@" %@ ", operation];
        self.operationLabel.text = [self.operationLabel.text stringByAppendingString:@" = "];
        
    }
    
}

- (IBAction)deleteLast:(id)sender {
    if (![display.text isEqualToString:@""]) {
        NSString *digitString = display.text;
        display.text = [digitString substringToIndex:[digitString length]-1];
    
        //NSString *operationLabelString = operationLabel.text;
        //operationLabel.text = [operationLabelString substringToIndex:[digitString length]-1];
    }
    else {
        display.text = @"0";
    }
}

@end
