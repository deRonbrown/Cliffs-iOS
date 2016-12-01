//
//  CFTrackingSummary.m
//  Pods
//
//  Created by DeRon Brown on 11/25/15.
//
//

#import "CFTrackingSummary.h"
#import "CFDefines.h"

@interface CFTrackingSummary ()

@property (nonatomic, assign, getter=isReported) BOOL reported;
@property (nonatomic, strong) NSMutableDictionary *flags;
@property (nonatomic, strong) NSMutableDictionary *counters;
@property (nonatomic, strong) NSMutableDictionary *attributes;
@property (nonatomic, strong) NSMutableDictionary *timers;

@end

@implementation CFTrackingSummary

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name {
    if (self = [super init]) {
        _identifier = identifier;
        _name = name;
        _flags = [NSMutableDictionary new];
        _counters = [NSMutableDictionary new];
        _attributes = [NSMutableDictionary new];
        _timers = [NSMutableDictionary new];
        
        CFTimer *timer = [[CFTimer alloc] initWithIdentifier:ATTR_TIME_SPENT];
        [timer start];
        _timers[ATTR_TIME_SPENT] = timer;
        
        [self setPreviousScreen:VAL_NONE];
    }
    
    return self;
}

- (void)initFlags:(NSArray *)flags {
    [flags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self setFlag:obj withValue:NO];
    }];
}

- (void)setFlag:(NSString *)name withValue:(BOOL)value {
    self.flags[name] = @(value);
}

- (void)setFlag:(NSString *)name {
    [self setFlag:name withValue:YES];
}

- (void)initCounters:(NSArray *)counters {
    [counters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self setCounter:obj withValue:0];
    }];
}

- (void)setCounter:(NSString *)name withValue:(NSInteger)value {
    self.counters[name] = @(value);
}

- (void)incrementCounter:(NSString *)name withValue:(NSInteger)value {
    NSNumber *previousValue = self.counters[name];
    if (previousValue) {
        self.counters[name] = @([previousValue integerValue] + value);
    } else {
        self.counters[name] = @(value);
    }
}

- (void)incrementCounter:(NSString *)name {
    [self incrementCounter:name withValue:1];
}

- (void)setAttribute:(NSString *)name withValue:(id)value {
    if (value) {
        self.attributes[name] = value;
    }
}

- (void)setPreviousScreen:(NSString *)screen {
    self.attributes[ATTR_PREVIOUS_SCREEN] = screen;
}

- (CFTimer *)timerForIdentifier:(NSString *)identifier {
    return self.timers[identifier];
}
- (void)addTimer:(CFTimer *)timer {
    self.timers[timer.identifier] = timer;
}

- (void)stopAllTimers {
    [self.timers enumerateKeysAndObjectsUsingBlock:^(NSString *key, CFTimer *timer, BOOL *stop) {
        [timer stop];
    }];
}

- (void)startAllTimers {
    [self.timers enumerateKeysAndObjectsUsingBlock:^(NSString *key, CFTimer *timer, BOOL *stop) {
        [timer start];
    }];
}

- (NSDictionary *)reportDictionary {
    self.reported = YES;
    
    NSMutableDictionary *report = [NSMutableDictionary new];
    
    [self.flags enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *num, BOOL *stop) {
        report[key] = [num boolValue] ? VAL_YES : VAL_NO;
    }];
    
    [self.timers enumerateKeysAndObjectsUsingBlock:^(NSString *key, CFTimer *timer, BOOL *stop) {
        [timer stop];
        report[key] = @(round(timer.cumulativeInterval));
    }];
    
    [report addEntriesFromDictionary:self.counters];
    [report addEntriesFromDictionary:self.attributes];
    
    return report;
}

#pragma mark - Abstract methods

- (BOOL)shouldReportOnBackground {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
