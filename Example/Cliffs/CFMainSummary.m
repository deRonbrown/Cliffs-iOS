//
//  CFMainSummary.m
//  Cliffs
//
//  Created by DeRon Brown on 11/29/15.
//  Copyright © 2015 DeRon Brown. All rights reserved.
//

#import "CFMainSummary.h"
#import "CFAnalyticsDefines.h"

@implementation CFMainSummary

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name {
    if (self = [super initWithIdentifier:identifier name:name]) {
        
        [self initFlags:@[FLAG_PRESS_ME_CLICKED, FLAG_CHANGE_COLOR]];
        [self initCounters:@[COUNT_PRESS_ME_CLICKS]];
    }
    
    return self;
}

- (BOOL)shouldReportOnBackground {
    return YES;
}

@end
