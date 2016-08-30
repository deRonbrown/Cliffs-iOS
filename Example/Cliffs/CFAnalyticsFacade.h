//
//  CFAnalyticsFacade.h
//  Cliffs
//
//  Created by DeRon Brown on 11/29/15.
//  Copyright © 2015 DeRon Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cliffs.h"

@interface CFAnalyticsFacade : NSObject

+ (CFTrackingSummary *)getMainSummary;
+ (CFTrackingSummary *)getSecondSummary:(NSString *)startColor;

@end
