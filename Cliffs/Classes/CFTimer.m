//
//  CFTimer.m
//  Pods
//
//  Created by DeRon Brown on 11/25/15.
//
//

#import "CFTimer.h"

@interface CFTimer ()

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) NSTimeInterval cumulativeInterval;
@property (nonatomic, assign) NSTimeInterval timerStart;
@property (nonatomic, assign) NSTimeInterval timerStop;
@property (nonatomic, assign, getter=isRunning) BOOL running;

@end

@implementation CFTimer

- (instancetype)initWithIdentifier:(NSString *)identifier {
    if (self = [super init]) {
        _identifier = identifier;
    }
    
    return self;
}

- (void)reset {
    self.timerStart = 0;
    self.timerStop = 0;
    self.running = NO;
}

- (void)start {
    if (self.timerStart == 0) {
        self.timerStart = [[NSDate date] timeIntervalSince1970];
    }
    
    self.running = YES;
}

- (void)stop {
    if (self.isRunning) {
        self.timerStop = [[NSDate date] timeIntervalSince1970];
        self.cumulativeInterval += self.timerStop - self.timerStart;
    }
    
    [self reset];
}

@end
