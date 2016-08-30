//
//  CFAppDelegate.m
//  Cliffs
//
//  Created by DeRon Brown on 11/25/2015.
//  Copyright (c) 2015 DeRon Brown. All rights reserved.
//

#import "CFAppDelegate.h"
#import "Localytics.h"
#import "Cliffs.h"
#import "CFAnalyticsFacade.h"

@interface CFAppDelegate () <CFAnalytics>

@end

@implementation CFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[Localytics setLoggingEnabled:YES];
    [Localytics autoIntegrate:@"INSERT_APP_KEY" launchOptions:launchOptions];
    
    [Cliffs setLoggingEnabled:YES];
    [Cliffs start:self];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Always create Main summary on foreground
    [CFAnalyticsFacade getMainSummary];
}

#pragma mark - CFAnalytics

- (void)trackScreen:(NSString *)screenName {
    [Localytics tagScreen:screenName];
}

- (void)tagEvent:(NSString *)eventName attributes:(NSDictionary *)attributes {
    [Localytics tagEvent:eventName attributes:attributes];
}

@end
