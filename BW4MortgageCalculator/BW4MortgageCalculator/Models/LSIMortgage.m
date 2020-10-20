//
//  LSIMortgage.m
//  BW4MortgageCalculator
//
//  Created by Waseem Idelbi on 10/14/20.
//

#import "LSIMortgage.h"

@implementation LSIMortgage

- (instancetype)initWithTerm:(int)term principal:(int)principal interestRate:(double)interestRate downPayment:(int)downPayment montlyPayment:(double)montlyPayment totalCost:(double)totalCost {
    
    if (self = [super init]) {
        _term = term;
        _principal = principal;
        _interestRate = interestRate;
        _downPayment = downPayment;
        _monthlyPayment = montlyPayment;
        _totalCost = totalCost;
    }
    return self;
}

// Turning our model into a dictionary
- (NSDictionary *)toDictionary {
    return @{
        @"term": [NSNumber numberWithInt:self.term],
        @"principal": [NSNumber numberWithInt:self.principal],
        @"interestRate": [NSNumber numberWithDouble:self.interestRate],
        @"downPayment": [NSNumber numberWithInt:self.downPayment],
        @"monthlyPayment": [NSNumber numberWithDouble:self.monthlyPayment],
        @"totalCost": [NSNumber numberWithDouble:self.totalCost],
    };
}

// Turning a dictionary into a model object
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber* termN = dictionary[@"term"];
    int term = [termN intValue];
    NSNumber* principalN = dictionary[@"principal"];
    int principal = [principalN intValue];
    NSNumber* interestRateN = dictionary[@"interest"];
    double interestRate = [interestRateN doubleValue];
    NSNumber* downPaymentN = dictionary[@"downPayment"];
    int downPayment = [downPaymentN intValue];
    NSNumber* monthlyPaymentN = dictionary[@"monthlyPayment"];
    double monthlyPayment = [monthlyPaymentN doubleValue];
    NSNumber* totalCostN = dictionary[@"totalCost"];
    double totalCost = [totalCostN doubleValue];
    return [self initWithTerm:term principal:principal interestRate:interestRate downPayment:downPayment montlyPayment:monthlyPayment totalCost:totalCost];
}

@end
