//
//  CFMainViewController.m
//  Cliffs
//
//  Created by DeRon Brown on 11/25/2015.
//  Copyright (c) 2015 DeRon Brown. All rights reserved.
//

#import "CFMainViewController.h"
#import "CFAnalyticsDefines.h"
#import "CFAnalyticsFacade.h"

@interface CFMainViewController ()

@end

@implementation CFMainViewController

#pragma mark - User actions

- (IBAction)pressMePressed:(id)sender {
    [self.cfTrackingSummary setFlag:FLAG_PRESS_ME_CLICKED];
    [self.cfTrackingSummary incrementCounter:COUNT_PRESS_ME_CLICKS];
}

#pragma mark - Analytics

- (BOOL)cf_isSimpleSummary {
    return NO;
}

- (NSString *)cf_screenName {
    return @"Main";
}

- (CFTrackingSummary *)cf_createSummary {
    return [CFAnalyticsFacade getMainSummary];
}

@end
