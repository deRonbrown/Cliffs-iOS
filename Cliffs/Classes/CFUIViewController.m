//
//  CFUIViewController.m
//  Pods
//
//  Created by DeRon Brown on 11/29/15.
//
//

#import "CFUIViewController.h"

@implementation CFUIViewController

#pragma mark - View lifecycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cf_appDidEnterBackground:)
                                                 name:CFAppEnterBackground
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cf_appDidEnterForeground:)
                                                 name:CFAppEnterForeground
                                               object:nil];
    
    NSString *previousScreen = [Cliffs trackScreen:[self cf_screenName]];
    if ([self cf_isSimpleSummary] || self.cfTrackingSummary == nil || self.cfTrackingSummary.isReported) {
        self.cfTrackingSummary = [self cf_createSummary];
        [self.cfTrackingSummary setPreviousScreen:previousScreen];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CFAppEnterBackground
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CFAppEnterForeground
                                                  object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if ([self cf_isSimpleSummary]) {
        [Cliffs reportSummary:self.cfTrackingSummary];
    }
}

#pragma mark - Notifications

- (void)cf_appDidEnterBackground:(NSNotification *)notification {
    if ([self cf_isSimpleSummary]) {
        [Cliffs reportSummary:self.cfTrackingSummary];
    }
}

- (void)cf_appDidEnterForeground:(NSNotification *)notification {
    NSString *previousScreen = [Cliffs trackScreen:[self cf_screenName]];
    if ([self cf_isSimpleSummary] || self.cfTrackingSummary.isReported) {
        self.cfTrackingSummary = [self cf_createSummary];
        [self.cfTrackingSummary setPreviousScreen:previousScreen];
    }
}

#pragma mark - Analytics

- (BOOL)cf_isSimpleSummary {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSString *)cf_screenName {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (CFTrackingSummary *)cf_createSummary {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
