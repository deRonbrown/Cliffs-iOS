//
//  CFTrackingSummary.h
//  Pods
//
//  Created by DeRon Brown on 11/25/15.
//
//

#import <Foundation/Foundation.h>
#import "CFTimer.h"

@interface CFTrackingSummary : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly, getter=isReported) BOOL reported;

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name;

- (void)initFlags:(NSArray *)flags;
- (void)setFlag:(NSString *)name withValue:(BOOL)value;
- (void)setFlag:(NSString *)name;

- (void)initCounters:(NSArray *)counters;
- (void)setCounter:(NSString *)name withValue:(NSInteger)value;
- (void)incrementCounter:(NSString *)name withValue:(NSInteger)value;
- (void)incrementCounter:(NSString *)name;

- (void)setAttribute:(NSString *)name withValue:(id)value;

- (void)setPreviousScreen:(NSString *)screen;

- (CFTimer *)timerForIdentifier:(NSString *)identifier;
- (void)addTimer:(CFTimer *)timer;
- (void)stopAllTimers;
- (void)startAllTimers;

- (NSDictionary *)reportDictionary;
- (BOOL)shouldReportOnBackground;

@end
