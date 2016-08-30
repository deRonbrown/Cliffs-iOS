//
//  CFSecondSummary.m
//  Cliffs
//
//  Created by DeRon Brown on 11/29/15.
//  Copyright © 2015 DeRon Brown. All rights reserved.
//

#import "CFSecondSummary.h"
#import "CFAnalyticsDefines.h"

@implementation CFSecondSummary

- (instancetype)initWithColor:(NSString *)color identifier:(NSString *)identifier name:(NSString *)name {
    if (self = [super initWithIdentifier:identifier name:name]) {
        [self initCounters:@[COUNT_SET_COLOR_CLICKS]];
        [self setAttribute:ATTRIBUTE_COLOR withValue:color];
    }
    
    return self;
}

- (BOOL)shouldReportOnBackground {
    return NO;
}

@end
