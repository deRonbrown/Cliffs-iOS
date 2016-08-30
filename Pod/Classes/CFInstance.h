//
//  CFInstance.h
//  Pods
//
//  Created by DeRon Brown on 11/29/15.
//
//

#import "Cliffs.h"

@interface CFInstance : NSObject

@property (nonatomic, assign, getter=isLoggingEnabled) BOOL loggingEnabled;

+ (instancetype)shared;

- (void)start:(id<CFAnalytics>)analytics;
- (NSString *)trackScreen:(NSString *)screenName;
- (void)tagEvent:(NSString *)eventName attributes:(NSDictionary *)attributes;
- (CFTrackingSummary *)addSummary:(CFTrackingSummary *)summary overwrite:(BOOL)overwrite;
- (CFTrackingSummary *)getSummary:(NSString *)identifier;
- (void)reportSummary:(CFTrackingSummary *)summary;

@end
