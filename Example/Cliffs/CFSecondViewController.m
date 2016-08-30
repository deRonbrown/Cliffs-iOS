//
//  CFSecondViewController.m
//  Cliffs
//
//  Created by DeRon Brown on 11/29/15.
//  Copyright © 2015 DeRon Brown. All rights reserved.
//

#import "CFSecondViewController.h"
#import "CFAnalyticsDefines.h"
#import "CFAnalyticsFacade.h"

@interface CFSecondViewController ()

@property (nonatomic, copy) NSString *startColor;

@end

@implementation CFSecondViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *randomColor = [self randomColor];
    self.view.backgroundColor = randomColor;
    self.startColor = [randomColor description];
}

#pragma mark - User actions

- (IBAction)changeColorPressed:(id)sender {
    UIColor *randomColor = [self randomColor];
    self.view.backgroundColor = randomColor;
    
    [self.cfTrackingSummary incrementCounter:COUNT_SET_COLOR_CLICKS];
    [[CFAnalyticsFacade getMainSummary] setFlag:FLAG_CHANGE_COLOR];
}

#pragma mark - Utils

- (UIColor *)randomColor {
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - Analytics

- (BOOL)cf_isSimpleSummary {
    return YES;
}

- (NSString *)cf_screenName {
    return @"Second";
}

- (CFTrackingSummary *)cf_createSummary:(NSString *)previousScreen {
    CFTrackingSummary *summary = [CFAnalyticsFacade getSecondSummary:self.startColor];
    [summary setPreviousScreen:previousScreen];
    return summary;
}

@end
