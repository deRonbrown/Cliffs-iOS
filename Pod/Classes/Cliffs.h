//
//  Cliffs.h
//  Pods
//
//  Created by DeRon Brown on 11/25/15.
//
//

#import <Foundation/Foundation.h>
#import "CFTrackingSummary.h"
#import "CFUIViewController.h"

@protocol CFAnalytics <NSObject>

@required

- (void)trackScreen:(NSString *)screenName;
- (void)tagEvent:(NSString *)eventName attributes:(NSDictionary *)attributes;

@end

@interface Cliffs : NSObject

+ (void)start:(id<CFAnalytics>)analytics;
+ (NSString *)trackScreen:(NSString *)screenName;
+ (void)tagEvent:(NSString *)eventName attributes:(NSDictionary *)attributes;
+ (CFTrackingSummary *)addSummary:(CFTrackingSummary *)summary overwrite:(BOOL)overwrite;
+ (CFTrackingSummary *)getSummary:(NSString *)identifier;
+ (void)reportSummary:(CFTrackingSummary *)summary;

+ (void)setLoggingEnabled:(BOOL)enabled;
+ (BOOL)isLoggingEnabled;

extern NSString *const CFAppEnterForeground;
extern NSString *const CFAppEnterBackground;

@end
