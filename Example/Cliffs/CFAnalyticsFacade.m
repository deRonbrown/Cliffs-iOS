//
//  CFAnalyticsFacade.m
//  Cliffs
//
//  Created by DeRon Brown on 11/29/15.
//  Copyright © 2015 DeRon Brown. All rights reserved.
//

#import "CFAnalyticsFacade.h"
#import "CFMainSummary.h"
#import "CFSecondSummary.h"

#define SUMMARY_MAIN @"summary_main"
#define SUMMARY_SECOND @"summary_second"

@implementation CFAnalyticsFacade

+ (CFTrackingSummary *)getMainSummary {
    CFTrackingSummary *summary = [Cliffs getSummary:SUMMARY_MAIN];
    if (summary == nil) {
        CFMainSummary *mainSummary = [[CFMainSummary alloc] initWithIdentifier:SUMMARY_MAIN
                                                                          name:@"Main Summary"];
        summary = [Cliffs addSummary:mainSummary overwrite:NO];
    }
    
    return summary;
}

+ (CFTrackingSummary *)getSecondSummary:(NSString *)startColor {
    CFTrackingSummary *summary = [Cliffs getSummary:SUMMARY_SECOND];
    if (summary == nil) {
        CFSecondSummary *secondSummary = [[CFSecondSummary alloc] initWithColor:startColor
                                                                     identifier:SUMMARY_SECOND
                                                                           name:@"Second Summary"];
        summary = [Cliffs addSummary:secondSummary overwrite:NO];
    }
    
    return summary;
}

@end
