//
//  LSIMortgage.m
//  BW4MortgageCalculator
//
//  Created by Waseem Idelbi on 10/14/20.
//

#import "LSIMortgage.h"

@implementation LSIMortgage

- (instancetype)initWithTerm:(int)term principal:(int)principal interestRate:(double)interestRate downPayment:(int)downPayment {
    
    if (self = [super init]) {
        _term = term;
        _principal = principal;
        _interestRate = interestRate;
        _downPayment = downPayment;
    }
    return self;
}

@end
