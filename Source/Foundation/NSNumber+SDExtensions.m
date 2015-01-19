//
//  NSNumber+SDExtensions.m
//  ios-shared
//
//  Created by Sam Grover on 6/28/13.
//  Copyright (c) 2013 SetDirection All rights reserved.
//

#import "NSNumber+SDExtensions.h"


@implementation NSNumber (SDExtensions)

+ (NSNumberFormatter *) commonCurrencyFormatter {
    static NSNumberFormatter *currencyFormatter = nil;
    static dispatch_once_t onceToken;
    /**
     Note that this is currently set to locale en_US but should be set to the correct locale
     once it needs to be localized to other regions and languages.
     */
    dispatch_once(&onceToken, ^{
        currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    });
    return currencyFormatter;
}

+ (NSNumberFormatter *) commonDecimalFormatter {
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    });
    return numberFormatter;
}

+ (NSNumber *)numberFromDollarString:(NSString *)argDollarString
{
    return [[self commonCurrencyFormatter] numberFromString:argDollarString];
}

+ (NSString *)dollarStringFromNumber:(NSNumber *)argNumber
{
    return [[self commonCurrencyFormatter] stringFromNumber:argNumber];
}

+ (NSNumber *)numberFromString:(NSString *)argString
{
    return [[self commonDecimalFormatter] numberFromString:argString];
}

+ (NSString *)stringFromNumber:(NSNumber *)argNumber
{
    return [[self commonDecimalFormatter] stringFromNumber:argNumber];
}
@end
