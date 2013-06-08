//
//  AppHelper.m
//  Cheerly
//
//  Created by Francisco Yarad on 6/7/13.
//  Copyright (c) 2013 Nixter, Inc. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper


+ (NSString *)humanTimeInterval:(NSDate*)date longformat:(BOOL)longf {
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
    if (interval == 0) return (longf) ? @"a few seconds" : @"1s";

    int second = 1;
    int minute = second*60;
    int hour = minute*60;
    int day = hour*24;
    int num = abs(interval);
    
    NSString *unit = @"d";
    
    if (num >= day) {
        num /= day;
        unit = (longf) ? ((num > 1) ? @" days" : @" day") : @"d";
    }
    else if (num >= hour) {
        num /= hour;
        unit = (longf) ? ((num > 1) ? @" hours" : @" hour") : @"h";
    }
    else if (num >= minute) {
        num /= minute;
        unit = (longf) ? ((num > 1) ? @" minutes" : @" minute") : @"m";
    }
    else if (num >= second) {
        num /= second;
        unit = (longf) ? ((num > 1) ? @" seconds" : @" second") : @"s";
    }
    
    return [NSString stringWithFormat:@"%d%@%@", num, unit, (longf) ? @" ago" : @""];
}

@end
