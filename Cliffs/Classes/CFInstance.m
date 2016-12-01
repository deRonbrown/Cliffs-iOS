//
//  CFInstance.m
//  Pods
//
//  Created by DeRon Brown on 11/29/15.
//
//

#import "CFInstance.h"
#import "CFDefines.h"

#define CFLog(message, ...) if ([CFInstance shared].isLoggingEnabled) \
NSLog(@"Cliffs: %@", [NSString stringWithFormat:message, ##__VA_ARGS__])

@interface CFInstance ()

@property (nonatomic, strong) NSMutableDictionary *summaries;
@property (nonatomic, copy) NSString *currentScreen;
@property (nonatomic, weak) id<CFAnalytics> analytics;

@end

@implementation CFInstance

#pragma mark - Singleton

+ (instancetype)shared {
    static CFInstance *cliffsInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cliffsInstance = [[CFInstance alloc] init];
    });
    
    return cliffsInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _summaries = [NSMutableDictionary new];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterForeground:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Analytics

- (void)start:(id<CFAnalytics>)analytics {
    self.analytics = analytics;
}

- (NSString *)trackScreen:(NSString *)screenName {
    NSString *lastScreen = self.currentScreen;
    self.currentScreen = screenName;
    NSString *previousScreen = [lastScreen length] > 0 ? lastScreen : VAL_NONE;
    CFLog(@"trackScreen: %@, lastScreen: %@", screenName, previousScreen);
    
    [self.analytics trackScreen:screenName];
    [self.analytics tagEvent:EVENT_VIEWED_SCREEN attributes:@{ATTR_SCREEN: screenName, ATTR_PREVIOUS_SCREEN: previousScreen}];
    
    return previousScreen;
}

- (void)tagEvent:(NSString *)eventName attributes:(NSDictionary *)attributes {
    [self.analytics tagEvent:eventName attributes:attributes];
}

- (CFTrackingSummary *)addSummary:(CFTrackingSummary *)summary overwrite:(BOOL)overwrite {
    NSString *identifer = summary.identifier;
    CFTrackingSummary *existingSummary = self.summaries[identifer];
    if (overwrite || existingSummary == nil) {
        [self reportSummary:existingSummary];
        self.summaries[identifer] = summary;
        CFLog(@"Created Summary: %@", identifer);
        return summary;
    } else {
        return existingSummary;
    }
}

- (CFTrackingSummary *)getSummary:(NSString *)identifier {
    return self.summaries[identifier];
}

- (void)reportSummaries:(NSArray *)summaries {
    [summaries enumerateObjectsUsingBlock:^(CFTrackingSummary *summary, NSUInteger idx, BOOL *stop) {
        [self reportSummary:summary];
    }];
}

- (void)reportSummary:(CFTrackingSummary *)summary {
    if (summary && !summary.isReported) {
        NSDictionary *report = [summary reportDictionary];
        [self tagEvent:summary.name attributes:report];
        [self.summaries removeObjectForKey:summary.identifier];
        CFLog(@"report summary: %@ with %@", summary.identifier, report);
    }
}

#pragma mark - Notifications

- (void)appDidEnterBackground:(NSNotification *)notification {
    CFLog(@"did enter background");
    NSMutableArray *toReport = [NSMutableArray new];
    [self.summaries enumerateKeysAndObjectsUsingBlock:^(NSString *key, CFTrackingSummary *summary, BOOL *stop) {
        if ([summary shouldReportOnBackground]) {
            [toReport addObject:summary];
        } else {
            [summary stopAllTimers];
        }
    }];
    
    self.currentScreen = nil;
    [self reportSummaries:toReport];
    [[NSNotificationCenter defaultCenter] postNotificationName:CFAppEnterBackground object:nil];
}

- (void)appDidEnterForeground:(NSNotification *)notification {
    CFLog(@"did enter foreground");
    [self.summaries enumerateKeysAndObjectsUsingBlock:^(NSString *key, CFTrackingSummary *summary, BOOL *stop) {
        [summary startAllTimers];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:CFAppEnterForeground object:nil];
}

@end
