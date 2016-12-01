//
//  CFTimer.h
//  Pods
//
//  Created by DeRon Brown on 11/25/15.
//
//

#import <Foundation/Foundation.h>

@interface CFTimer : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, assign, readonly) NSTimeInterval cumulativeInterval;

- (instancetype)initWithIdentifier:(NSString *)identifier;

- (void)reset;
- (void)start;
- (void)stop;

@end
