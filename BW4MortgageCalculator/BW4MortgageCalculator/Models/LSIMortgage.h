//
//  LSIMortgage.h
//  BW4MortgageCalculator
//
//  Created by Waseem Idelbi on 10/14/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIMortgage : NSObject

@property (nonatomic) int term;
@property (nonatomic) int principal;
@property (nonatomic) int downPayment;
@property (nonatomic) double interestRate;

- (instancetype)initWithTerm:(int)term principal:(int)principal interestRate:(double)interestRate downPayment:(int)downPayment;

@end

NS_ASSUME_NONNULL_END
