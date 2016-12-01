//
//  Cliffs.m
//  Pods
//
//  Created by DeRon Brown on 11/25/15.
//
//

#import "Cliffs.h"
#import "CFInstance.h"

#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation Cliffs

NSString *const CFAppEnterForeground = @"xspotlivin:CFAppEnterForeground";
NSString *const CFAppEnterBackground = @"xspotlivin:CFAppEnterBackground";

+ (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:[CFInstance shared]];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [[CFInstance shared] methodSignatureForSelector:selector];
}

@end
